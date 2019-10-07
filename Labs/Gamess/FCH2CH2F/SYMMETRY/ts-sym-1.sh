#!/bin/bash
#$ -pe smp 4
#$ -q debug
#$ -N gamess
module load gamess

THISNAME=ts-sym-1
MYRUNGAMESS=$HOME/CBE60547/Labs/Gamess/bin/rungms

cat <<EOF > ~/.gmsrc
set SCR=/scratch365/$USER
set USERSCR=$PWD
EOF

cat<<'EOF' > $THISNAME.inp
 $CONTRL SCFTYP=RHF DFTTYP=PBE RUNTYP=OPTIMIZE COORD=ZMT NZVAR=18 ISPHER=1 $END
 $BASIS GBASIS=PCseg-1 $END
 $DATA
FCH2CH2F eclipsed TS
CS

C
C   1   r1
F   2   r2   1   A1
H   2   r3   1   A2   3   D1
H   2   r4   1   A3   3   D2
F   1   r5   2   A4   3   D3
H   1   r6   2   A5   6   D4
H   1   r7   2   A6   6   D5

r1=1.5
r2=1.4
r3=1.1
r4=1.1
r5=1.5
r6=1.1
r7=1.1
A1=109.54214
A2=109.54214
A3=109.54214
A4=109.54214
A5=109.54214
A6=109.54214
D1=120.
D2=-120.
D3=0.
D4=120.
D5=-120.
 $END

EOF
$MYRUNGAMESS $THISNAME.inp > $THISNAME.out

grep 'NSERCH:' $THISNAME.out | gawk '{print $4, $7, $9}' > $THISNAME.sum

