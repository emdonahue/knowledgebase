.PHONE: doc
doc:
	sed -i -n '1,/^## Documentation/ p' README.md
	echo '```' >> README.md
	./kb help >> README.md
	echo '```' >> README.md
	echo '## Configuration' >> README.md
	echo '```' >> README.md
	sed -En '/> .config/ s/.*echo "([^"]+).*/\1/p' kb >> README.md
	echo '```' >> README.md
	echo '## TODO' >> README.md
	sed -nE 's/.*#TODO (.*)/- \1/p' kb >> README.md
