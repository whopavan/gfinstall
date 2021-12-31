SHELL=/bin/bash
currVer = 0
fullCurVer = 0

updateDebVersion:
	@currentVersion=${shell head -1 debian/changelog | cut -d '(' -f2 | cut -d ')' -f1}; \
	echo "Old Version: $$currentVersion"
	@read -p "New Version: " ver; \
	dch -v $$ver

currentVersion:
	fullCurVer=${shell head -1 debian/changelog | cut -d '(' -f2 | cut -d ')' -f1};
	curVer=${shell head -1 debian/changelog | cut -d '(' -f2 | cut -d ')' -f1 | cut -d '-' -f1};

damn: clean updateGFList
	@echo "Damn"

clean:
	@echo "Cleaning build"

updateGFList:
	@echo "Updating Google Fonts list"