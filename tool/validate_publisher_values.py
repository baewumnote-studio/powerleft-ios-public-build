from pathlib import Path
import argparse
import json
import re
import sys
from urllib.parse import urlparse

ROOT = Path(__file__).resolve().parents[1]
VALUES = ROOT / "PUBLISHER_VALUES_REQUIRED.json"

parser = argparse.ArgumentParser()
parser.add_argument("--values", default=str(VALUES), help="publisher-values JSON path")
parser.add_argument(
    "--release",
    action="store_true",
    help="require every release-required publisher value to be resolved",
)
args = parser.parse_args()

values_path = Path(args.values)
data = json.loads(values_path.read_text(encoding="utf-8"))
errors = []
warnings = []

required_keys = {
    "bundleId",
    "appleTeamId",
    "adMobPublisherId",
    "adMobIosAppId",
    "adMobInterstitialIosUnitId",
    "developerWebsiteUrl",
    "privacyPolicyUrl",
    "privacyChoicesUrl",
    "supportUrl",
    "supportEmail",
    "appReviewContactName",
    "appReviewContactEmail",
    "appReviewContactPhone",
    "dsaTraderStatus",
    "dsaPublicAddress",
    "dsaPublicPhone",
    "dsaPublicEmail",
}
missing_keys = required_keys - set(data)
if missing_keys:
    errors.append(f"missing publisher keys: {sorted(missing_keys)}")

def unresolved(value):
    return not isinstance(value, str) or value.startswith("<")

def require_resolved(key):
    value = data.get(key)
    if unresolved(value):
        if args.release:
            errors.append(f"{key}: unresolved publisher placeholder")
        else:
            warnings.append(f"{key}: unresolved as expected in template mode")
        return None
    return value.strip()

bundle = require_resolved("bundleId")
if bundle and not re.fullmatch(
    r"[A-Za-z0-9-]+(?:\.[A-Za-z0-9-]+){2,}",
    bundle,
):
    errors.append("bundleId: expected reverse-domain identifier")

team = require_resolved("appleTeamId")
if team and not re.fullmatch(r"[A-Za-z0-9]{10}", team):
    warnings.append(
        "appleTeamId: common Apple Team IDs are 10 alphanumeric characters; verify manually"
    )

publisher = require_resolved("adMobPublisherId")
if publisher and not re.fullmatch(r"pub-\d{16}", publisher):
    errors.append("adMobPublisherId: expected pub- followed by 16 digits")

app_id = require_resolved("adMobIosAppId")
if app_id and not re.fullmatch(r"ca-app-pub-\d{16}~\d+", app_id):
    errors.append("adMobIosAppId: unexpected AdMob iOS App ID format")

unit_id = require_resolved("adMobInterstitialIosUnitId")
if unit_id and not re.fullmatch(r"ca-app-pub-\d{16}/\d+", unit_id):
    errors.append("adMobInterstitialIosUnitId: unexpected interstitial unit format")

def validate_https(key, optional=False):
    value = data.get(key, "")
    if optional and (value == "" or unresolved(value)):
        if unresolved(value) and not args.release:
            warnings.append(f"{key}: unresolved optional URL")
        return
    resolved = require_resolved(key)
    if not resolved:
        return
    parsed = urlparse(resolved)
    if parsed.scheme != "https" or not parsed.netloc:
        errors.append(f"{key}: must be a public https URL")

validate_https("developerWebsiteUrl")
validate_https("privacyPolicyUrl")
validate_https("supportUrl")
validate_https("privacyChoicesUrl", optional=True)

for key in ["supportEmail", "appReviewContactEmail"]:
    value = require_resolved(key)
    if value and not re.fullmatch(r"[^@\s]+@[^@\s]+\.[^@\s]+", value):
        errors.append(f"{key}: invalid email format")

phone = require_resolved("appReviewContactPhone")
if phone and not re.fullmatch(r"\+[0-9][0-9 ()-]{6,}", phone):
    errors.append(
        "appReviewContactPhone: must be in international format beginning with +"
    )

require_resolved("appReviewContactName")

status = require_resolved("dsaTraderStatus")
if status:
    normalized = status.strip().lower().replace("_", "-")
    if normalized not in {"trader", "non-trader", "nontrader"}:
        errors.append("dsaTraderStatus: use trader or non-trader")
    elif normalized == "trader":
        for key in ["dsaPublicAddress", "dsaPublicPhone", "dsaPublicEmail"]:
            require_resolved(key)
    elif args.release:
        # Non-trader fields may remain not-applicable placeholders.
        pass

if errors:
    print("PUBLISHER VALUES VALIDATION FAILED")
    for error in errors:
        print("ERROR:", error)
    for warning in warnings:
        print("WARN:", warning)
    sys.exit(1)

print("PUBLISHER VALUES VALIDATION PASSED")
print("Mode:", "release" if args.release else "template")
print("Warnings:", len(warnings))
for warning in warnings:
    print("WARN:", warning)
