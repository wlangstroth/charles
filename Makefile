# Regarding this gross hackery, I can only say:
# https://www.youtube.com/watch?v=Sv4Gui9hKCM

base_dir = /var/www/charles
staging_dir = /var/www/staging/charles/current
current_dir = $(base_dir)/current

build:
	cabal clean
	cabal install -fdevelopment --reorder-goals

sync:
	rsync -avz static/img deploy@ministry:$(current_dir)/static/
	rsync devel.cfg deploy@ministry:$(current_dir)/

remote_build:
	ssh deploy@ministry 'cd $(current_dir); \
		git pull; \
		bash -c -l "cabal install --reorder-goals";'

restart:
	ssh ministry 'service charles restart'

staging: build_staging sync_staging restart_staging

production: remote_build sync restart
