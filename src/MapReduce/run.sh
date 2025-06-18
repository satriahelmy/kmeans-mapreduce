#!/bin/bash
i=1
while :
do
	hadoop jar /home/bigdata/hadoop-3.2.2/share/hadoop/tools/lib/hadoop-streaming-3.2.2.jar -file centroids.txt -file ./mapper.py -mapper ./mapper.py -file ./reducer.py -reducer ./reducer.py -input /testMapReduce/dataset -output /testMapReduce/mapreduce-output$i
	rm -f centroids1.txt
	hadoop fs -copyToLocal /testMapReduce/mapreduce-output$i/part-00000 centroids1.txt
	seeiftrue=`python reader.py`
	if [ $seeiftrue = 1 ]
	then
		rm centroids.txt
		hadoop fs -copyToLocal /testMapReduce/mapreduce-output$i/part-00000 centroids.txt
		break
	else
		rm centroids.txt
		hadoop fs -copyToLocal /testMapReduce/mapreduce-output$i/part-00000 centroids.txt
	fi
	i=$((i+1))
done
