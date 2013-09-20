#!/bin/bash
rake deploy
git add .
git commit -m 'publicate'
git push -u origin source
