#!/usr/bin/python3

# Usage:
# python3 injest-papers.py papers-form-output.csv papers/SIGBOVIK_20XX
#  (pun intended)

# does an initial paper ingest from a google form with 


import csv, sys, subprocess, os, re

if len(sys.argv) != 3:
	print("Usage:\n\tpython3 injest-papers.py [papers-from-output.csv] [prefix/FOR_PAPER_FILES]", file=sys.stderr)
	exit(1)

[papersFile, prefix] = sys.argv[1:]

print(f"Will read from {papersFile} and download to {prefix}_paper_N.pdf")

TRACK = 'TRACK'
TITLE = 'TITLE'
AUTHORS = 'AUTHOR'
PDF = 'URL'
EMAIL = 'EMAIL'
# TRACK = 'Which track are you submitting to?'
# TITLE = 'Paper Title'
# AUTHORS = 'Paper Author Names'
# PDF = 'Paper PDF Link'
# EMAIL = 'Email Address'

papers_tex = []

id = 0
with open(papersFile, newline='', errors="ignore", encoding="utf-8-sig") as csvfile:
	reader = csv.DictReader(csvfile)
	for row in reader:
		# print(row)
		id += 1;
		track = row[TRACK]
		title = row[TITLE]
		authors = row[AUTHORS].split('\n')
		pdf = row[PDF]
		url = row[PDF]

		#if id != 62: continue

		filename = f"{prefix}_paper_{id}.pdf"
		print(filename)

		m = re.match(r'^(https://drive.google.com/file/d/)([^/]+)/view.*$', url)
		if m != None:
			print ("     -- google drive remap")
			url = f"https://drive.google.com/u/0/uc?id={m[2]}&export=download"

		m = re.match(r'^(https://github.com/[^/]+/[^/]+)/blob/(.*.pdf)$', url)
		if m != None:
			print ("     -- github remap")
			url = f"{m[1]}/raw/{m[2]}"

		m = re.match(r'^(https://gitlab.com/[^/]+/[^/]+/-)/blob/(.*.pdf)$', url)
		if m != None:
			print ("     -- gitlab remap")
			url = f"{m[1]}/raw/{m[2]}?inline=false"

		#onedrive is particularly onerous and you are on your own for it, I think

		
		if os.path.exists(filename):
			pass
		else:
			print(f"    Fetching from: '{url}'")
			subprocess.run(['wget', '-q', '--show-progress', url, '-O', filename])

		info = subprocess.run(['file', filename], capture_output=True).stdout.decode('utf8')

		print(f"    {info}")
		print(f"    {track}")
		print(f"    {title}")
		print(f"    {', '.join(authors)}")

		if re.match(r'.*: PDF document', info) == None:
			print("  ***WARNING***")
			print(f"   current url: '{url}'")
			print(f"   original url: '{row[PDF]}'")
			print(f"   contact: {row[EMAIL]}")
			exit(1)

		if len(authors) <= 2:
			authors = ' and '.join(authors)
		else:
			authors = ', '.join(authors[:-1]) + ', and ' + authors[-1]

		filename = filename[len('papers/'):]

		papers_tex.append('\\addpaper')
		papers_tex.append(f'\t{{{title}}}') #title
		papers_tex.append(f'\t{{{authors}}}') #authors
		papers_tex.append(f'\t{{}}') #keywords
		papers_tex.append(f'\t{{{filename}}}') #filename
		papers_tex.append(f'\t{{0cm}}') #??
		papers_tex.append(f'\t{{}}') #badges


print("Writing to 'papers-injest.tex'...")
open('papers-injest.tex', 'w').write('\n'.join(papers_tex) + '\n')


