"""Only accept manual main-branch builds, and require an exact-commit unsigned pass."""
import json
import os
import re
import urllib.request

REPOSITORY = 'baewumnote-studio/powerleft-ios-public-build'

def get(path):
    request = urllib.request.Request('https://api.github.com/repos/'+REPOSITORY+path,
        headers={'Authorization':'Bearer '+os.environ['GH_TOKEN'],
                 'Accept':'application/vnd.github+json','X-GitHub-Api-Version':'2022-11-28'})
    with urllib.request.urlopen(request,timeout=30) as response:
        return json.load(response)

def main():
    if (os.environ.get('GITHUB_REPOSITORY')!=REPOSITORY
        or os.environ.get('GITHUB_EVENT_NAME')!='workflow_dispatch'
        or os.environ.get('GITHUB_REF')!='refs/heads/main'):
        raise ValueError('Only a manual main-branch run in the approved repository is allowed.')
    mode=os.environ.get('POWERLEFT_MODE')
    if mode not in ('unsigned','testflight'):
        raise ValueError('Invalid build mode.')
    if mode=='unsigned':
        print('PASS: unsigned compilation request; no signing secrets used.')
        return
    if not re.fullmatch(r'[1-9][0-9]{0,6}',os.environ.get('POWERLEFT_BUILD_NUMBER','')):
        raise ValueError('Use a positive integer build number, up to seven digits.')
    run_id=os.environ.get('POWERLEFT_VERIFIED_RUN_ID','')
    if not re.fullmatch(r'[1-9][0-9]+',run_id):
        raise ValueError('A successful unsigned run ID is required before signing.')
    run=get('/actions/runs/'+run_id)
    if (run['head_sha']!=os.environ['GITHUB_SHA'] or run['head_branch']!='main'
        or run['event']!='workflow_dispatch' or run['conclusion']!='success'
        or run['path']!='.github/workflows/ios-build.yml'
        or run['repository']['full_name']!=REPOSITORY):
        raise ValueError('Previous unsigned verification must match this exact source commit.')
    jobs=get('/actions/runs/'+run_id+'/jobs?per_page=100')['jobs']
    compile_jobs=[j for j in jobs if j['name']=='compile']
    if len(compile_jobs)!=1 or compile_jobs[0]['conclusion']!='success':
        raise ValueError('The referenced run did not successfully compile an unsigned iOS release.')
    print('PASS: exact-commit unsigned iOS compilation verified before signing.')

if __name__=='__main__':
    try: main()
    except Exception as error:
        if isinstance(error,ValueError): print('STOP: '+str(error))
        else: print('STOP: cannot confirm previous compilation; '+type(error).__name__)
        raise SystemExit(1)
