# Regarding this gross hackery, I can only say:
# https://www.youtube.com/watch?v=Sv4Gui9hKCM

deploy_dir = /var/www/charles/current
build:
	cabal clean
	cabal install -fdevelopment --max-backjumps=-1

sync:
	rsync -avz static/img deploy@ministry:$(deploy_dir)/static/
	rsync devel.cfg deploy@ministry:$(deploy_dir)/

remote_pull:
	ssh -t deploy@ministry 'cd $(deploy_dir); git pull'

remote_build:
	ssh -t deploy@ministry 'cd $(deploy_dir); bash -l -c "cabal install"'

restart:
	ssh ministry 'service charles restart'

deploy: remote_pull remote_build sync restart
