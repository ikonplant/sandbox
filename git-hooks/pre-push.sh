#!/usr/bin/env bash
LOCAL_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
PATTERN="^(release)\/(\d+\.){1,2}\d+?$|^(master|development|staging|production)$|^jira-\d+\/[a-z0-9-]+$"
if ! [[ "$LOCAL_BRANCH" =~ $PATTERN ]]; then
    printf "${RED}!§\$&#*\?\$§! Bad boy!!! Bad branch name \'${LOCAL_BRANCH}\'! Your commit will be rejected!\n"
    printf "${NC}Use our pattern: ${YELLOW}${PATTERN}\n"
    exit 1
fi