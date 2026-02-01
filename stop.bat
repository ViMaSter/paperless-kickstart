@echo off
setlocal EnableDelayedExpansion

cd paperless
docker compose -p paperless_daniel down
