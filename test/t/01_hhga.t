#!/usr/bin/env bash

BASH_TAP_ROOT=../deps/bash-tap
. ../deps/bash-tap/bash-tap-bootstrap

PATH=../bin:$PATH # for vg

export LC_ALL="C" # force a consistent sort order 

plan tests 8

hhga -h 2>/dev/null
is $? 0 "hhga help runs"

is $(hhga -b minigiab/NA12878.chr22.tiny.bam -f minigiab/q.fa -v minigiab/NA12878.chr22.tiny.giab.vcf.gz -t -r q:10502-10562 | md5sum | cut -f 1 -d\ ) 72e29b7afcafad482de22f28640ced46 "expected output produced for a test region"

is $(hhga -b minigiab/NA12878.chr22.tiny.bam -f minigiab/q.fa -v minigiab/NA12878.chr22.tiny.giab.vcf.gz -r q:10502-10562 -c 1 | md5sum | cut -f 1 -d\ ) 1f4a6f8ce14e69b0e83cb0c5d6158667 "expected vw-format output produced for a test region"

is $(hhga -b minigiab/NA12878.chr22.tiny.bam -f minigiab/q.fa -v minigiab/h.vcf.gz -r q:9251-9252 -t -sa | grep ^hap | grep 'AAG----' | wc -l ) 1 "a normalized left-aligned indel is properly handled in the haplotypes"

is $(hhga -b minigiab/NA12878.chr22.tiny.bam -f minigiab/q.fa -v minigiab/h.vcf.gz  -w 64 -t | grep 'S\.' | wc -l) 14 "soft clips are annotated as expected"

is $(hhga -b minigiab/NA12878.chr22.tiny.bam -f minigiab/q.fa -v minigiab/NA12878.chr22.tiny.giab.vcf.gz -r q:10502-10562 -w 32 -s -t | grep "AAAAACAAAAAAC-AA-AAAAAAAAGGAAGGA" | wc -l ) 1 "reference allele compression is configurable"

is $(hhga -b minigiab/NA12878.chr22.tiny.bam -f minigiab/q.fa -v minigiab/NA12878.chr22.tiny.giab.vcf.gz -r q:10502-10562 -c 1 | hhga -p | md5sum | cut -f 1 -d\ ) fa6d278a26e3477df10131767d6ee5ac "expected vcf-format output produced for a test region"

is $(hhga -b minigiab/NA12878.chr22.tiny.bam -f minigiab/q.fa -v minigiab/NA12878.chr22.tiny.giab.vcf.gz -r q:10502-10562 -g GT | hhga -G | md5sum | cut -f 1 -d\ ) a5cde582888857a67712dc28b0fe7666 "expected vcf-format output produced for a test region with genotype class"
