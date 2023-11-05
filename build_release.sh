#!/bin/bash
source ./setup_env.sh
mix deps.get

mix compile
mix assets.deploy

mix release

echo "if you changed the database since the last release then run _build/dev/rel/score_goblin/bin/migrate before starting the server"
