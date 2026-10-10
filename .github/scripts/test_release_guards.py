"""Refuse wrong distribution profiles and unverified signing requests."""
import copy
from datetime import datetime, timedelta, timezone
import hashlib
import os
from unittest import TestCase, main, mock
import app_store
import verify_request

class AppStoreProfileGuards(TestCase):
    def setUp(self):
        self.cert=b'public test certificate placeholder'
        self.patch=mock.patch.object(app_store,'CERTIFICATE_SHA256',hashlib.sha256(self.cert).hexdigest())
        self.patch.start(); self.addCleanup(self.patch.stop)
        self.profile={'ExpirationDate':datetime.now(timezone.utc)+timedelta(days=30),
            'TeamIdentifier':[app_store.TEAM],
            'Entitlements':{'com.apple.developer.team-identifier':app_store.TEAM,
                'application-identifier':app_store.TEAM+'.'+app_store.BUNDLE,
                'get-task-allow':False,'beta-reports-active':True},
            'DeveloperCertificates':[self.cert],
            'UUID':'00000000-0000-4000-8000-000000000001','Name':'Public fixture'}

    def test_correct_app_store_profile(self): app_store.validate_profile(self.profile)
    def test_ad_hoc_profile_refused(self):
        self.profile['ProvisionedDevices']=['public test device placeholder']
        with self.assertRaises(ValueError): app_store.validate_profile(self.profile)
    def test_development_profile_refused(self):
        self.profile['Entitlements']['get-task-allow']=True
        with self.assertRaises(ValueError): app_store.validate_profile(self.profile)
    def test_wrong_bundle_refused(self):
        self.profile['Entitlements']['application-identifier']=app_store.TEAM+'.com.example.other'
        with self.assertRaises(ValueError): app_store.validate_profile(self.profile)
    def test_wrong_team_refused(self):
        self.profile['TeamIdentifier']=['OTHERTEAM0']
        with self.assertRaises(ValueError): app_store.validate_profile(self.profile)
    def test_other_certificate_refused(self):
        self.profile['DeveloperCertificates']=[b'other certificate']
        with self.assertRaises(ValueError): app_store.validate_profile(self.profile)
    def test_expiring_profile_refused(self):
        self.profile['ExpirationDate']=datetime.now(timezone.utc)+timedelta(hours=12)
        with self.assertRaises(ValueError): app_store.validate_profile(self.profile)
    def test_enterprise_profile_refused(self):
        self.profile['ProvisionsAllDevices']=True
        with self.assertRaises(ValueError): app_store.validate_profile(self.profile)
    def test_unrequested_app_group_refused(self):
        self.profile['Entitlements']['com.apple.security.application-groups']=['group.other']
        with self.assertRaises(ValueError): app_store.validate_profile(self.profile)
    def test_production_cannot_accidentally_use_test_ads(self):
        with self.assertRaises(ValueError): app_store.validate_public_ids(False,app_store.TEST_APP,app_store.TEST_UNIT)
    def test_admob_publisher_must_match(self):
        with self.assertRaises(ValueError):
            app_store.validate_public_ids(False,'ca-app-pub-1111111111111111~1111111111','ca-app-pub-2222222222222222/2222222222')
    def test_explicit_test_ads_remain_official(self):
        self.assertEqual(app_store.validate_public_ids(True,'',''),(app_store.TEST_APP,app_store.TEST_UNIT))
    def test_verified_powerleft_production_pair_accepted(self):
        self.assertEqual(app_store.validate_public_ids(False,app_store.PRODUCTION_APP,app_store.PRODUCTION_UNIT),
                         (app_store.PRODUCTION_APP,app_store.PRODUCTION_UNIT))
    def test_other_app_in_same_admob_account_refused(self):
        with self.assertRaises(ValueError):
            app_store.validate_public_ids(False,'ca-app-pub-9507165963073699~1111111111',
                                          'ca-app-pub-9507165963073699/2222222222')

class PreviousCompilationGuards(TestCase):
    def setUp(self):
        self.environment={'GITHUB_REPOSITORY':verify_request.REPOSITORY,'GITHUB_EVENT_NAME':'workflow_dispatch',
            'GITHUB_REF':'refs/heads/main','GITHUB_SHA':'a'*40,'POWERLEFT_MODE':'testflight',
            'POWERLEFT_BUILD_NUMBER':'2','POWERLEFT_VERIFIED_RUN_ID':'12345'}
        self.patch=mock.patch.dict(os.environ,self.environment,clear=True); self.patch.start(); self.addCleanup(self.patch.stop)
        self.run={'head_sha':'a'*40,'head_branch':'main','event':'workflow_dispatch','conclusion':'success',
            'path':'.github/workflows/ios-build.yml','repository':{'full_name':verify_request.REPOSITORY}}
        self.jobs={'jobs':[{'name':'compile','conclusion':'success'}]}
    def run_guard(self):
        with mock.patch.object(verify_request,'get',side_effect=[self.run,self.jobs]): verify_request.main()
    def test_exact_source_compile_pass_accepted(self): self.run_guard()
    def test_old_commit_refused(self):
        self.run['head_sha']='b'*40
        with self.assertRaises(ValueError): self.run_guard()
    def test_failed_compile_refused(self):
        self.jobs['jobs'][0]['conclusion']='failure'
        with self.assertRaises(ValueError): self.run_guard()
    def test_signing_run_cannot_substitute_for_compile(self):
        self.jobs={'jobs':[{'name':'testflight','conclusion':'success'}]}
        with self.assertRaises(ValueError): self.run_guard()
    def test_external_pull_request_refused(self):
        os.environ['GITHUB_EVENT_NAME']='pull_request'
        with self.assertRaises(ValueError): self.run_guard()
    def test_invalid_build_number_refused(self):
        os.environ['POWERLEFT_BUILD_NUMBER']='2;exit 0'
        with self.assertRaises(ValueError): self.run_guard()

if __name__=='__main__': main()
