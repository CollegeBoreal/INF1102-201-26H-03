ssh -i ~/.ssh/b300098957@ramena root@10.7.237.16 'qm list | awk "NR>1 {print \$2 \" \" \$3}"'

