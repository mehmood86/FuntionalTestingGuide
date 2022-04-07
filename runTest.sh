#!/bin/bash

#download system compatible geckodriver, extract it and place it /usr/bin
#geckodriver download link: https://github.com/mozilla/geckodriver/releases
#sudo apt install firefox-geckodriver #Alternative: may also work smoothly

REMOTE="https://github.com/mehmood86/ELNST"
LOCAL="ELNST"
SupressWarning="Requirement already satisfied"
git clone $REMOTE $LOCAL 2> /dev/null || (cd $LOCAL; git pull)

python3 -m pip install --user --upgrade pip virtualenv | grep -v "$SupressWarning"

SELENIUMTESTS="seleniumTests/Tests"
cd $LOCAL && python3 -m venv env && source env/bin/activate && python3 -m pip install -r requirements.txt | grep -v "$SupressWarning"

URL="http://localhost:3000/home"

prettify(){
    echo "====================================="
    echo -e "\033[33m "$1 "\033[0m"
    echo "====================================="
}

prettify "1- running userManagement.py"         && URL=$URL python3 $SELENIUMTESTS/userManagement.py
prettify "2- running user_validation.py"         && URL=$URL python3 $SELENIUMTESTS/userValidation.py
prettify "3- running topFrameInteraction.py "   && URL=$URL python3 $SELENIUMTESTS/topFrameInteraction.py

#Following test may require following command to load sample collections
#bundle exec bin/delayed_job restart

prettify "4- running sampleProperties.py "      && URL=$URL python3 $SELENIUMTESTS/sampleProperties.py
prettify "5- running sampleInteraction.py "     && URL=$URL python3 $SELENIUMTESTS/sampleInteraction.py
prettify "6- running collectionInteraction.py " && URL=$URL python3 $SELENIUMTESTS/collectionInteraction.py
