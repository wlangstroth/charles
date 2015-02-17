# Regarding this gross hackery, I can only say:
# https://www.youtube.com/watch?v=Sv4Gui9hKCM

base_dir = /var/www/charles
current_dir = $(base_dir)/current
release_dir = $(base_dir)/releases
shared_dir = $(base_dir)/shared
timestamp := $(shell date "+%Y%m%d%H%M%S")

dev_build:
	cabal clean
	cabal install -fdevelopment --reorder-goals

sync:
	rsync -avz static/img deploy@ministry:$(current_dir)/static/
	rsync devel.cfg deploy@ministry:$(current_dir)/

remote_build:
	ssh deploy@ministry 'mkdir -p $(release_dir); \
		mkdir -p $(shared_dir); \
		cd $(release_dir); \
		git clone https://github.com/wlangstroth/charles.git $(timestamp)/; \
		rm -f $(current_dir); \
		ln -s $(release_dir)/$(timestamp) $(current_dir); \
		cd $(current_dir); \
		bash -c -l "cabal sandbox init --sandbox $(base_dir)/shared; cabal install --reorder-goals";'

restart:
	ssh ministry 'service charles restart'

deploy: remote_build sync restart
