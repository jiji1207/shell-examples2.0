#!/usr/bin/env bash


#统计访问来源主机TOP 100和分别对应出现的总次数
 
function host_top100 
{
	printf "访问次数  来源主机\n"
    awk -F "\t" '
	NR>1 {a[$1]++;}
	END{
		for(i in a)	
		{printf("%d       %-10s\n",a[i],i);}
	}' web_log.tsv | sort -g -k 1 -r | head -n 100
}


#统计访问来源主机Top100IP和分别对应出现的总次数

function ip_top100
{
	printf "访问来源主机出现的次数 访问来源主机\n"
    awk -F "\t" '
	{
		if($1~/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/)
		{print  $1}
	}' web_log.tsv | sort | uniq -c | sort -nr | head -n 100
}


#统计最频繁被访问的URL TOP 100

function URL_top_100 
{
   	printf "被访问的次�URL\n"
    awk -F "\t" '
	{
		{print $5}
	}' web_log.tsv | sort | uniq -c | sort -nr | head -n 100
}


# function: 统计不同响应状态码的出现次数和对应百分比

function respone 
{
	printf "相应码 出现次数 百分比\n"
    awk -F "\t" '
	BEGIN{sum=0}{
		if(NR>1)
		{a[$6]++};
		sum++
	}
	END{
		for(i in a)
		{printf("%s  %-10d  %-10.4f%\n",i,a[i],a[i]*100/sum)}
	}' web_log.tsv |sort -g -k 2 -r
}


#分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数

function 4xx_URL_top10 
{
	printf "403:\n"
	printf "出现的总次数  状态码\n"
    awk -F "\t" '
	{
		if($6==403)
		{print $5}
	}' web_log.tsv| sort | uniq -c| sort -nr|head -n 10
	printf "404:\n"
	printf "出现的总次数  状态码\n"
    awk -F "\t" '
	{
		if($6==404)
		{print $5}
	}' web_log.tsv| sort | uniq -c| sort -nr|head -n 10
}


#输出给定URL访问Top100的来源主机

function source_host 
{
	printf "输出的次数  来源主机\n"
    awk -F "\t" '
	{
		if("'"$1"'"==$5)
		{print $1}
	}' web_log.tsv| sort |uniq -c | sort -nr | head -n 100
}


#帮助文档

function help
{
        echo "PARAMETERS HELP INFO:"
        echo ":=======================================================================================:"
        echo "-t      统计访问来源主机TOP 100和分别对应出现的总次数"
        echo "-i      统计访问来源主机Top 100 IP和分别对应出现的总次数"
        echo "-u      统计最频繁被访问的URL TOP 100"
        echo "-r      统计不同响应状态码的出现次数和对应百分比"
        echo "-x      分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数"
        echo "-s [url]   输出给定URL访问Top100的来源主机"
        echo "-h       帮助文档"
}



while [ "$1" != "" ];
do
case "$1" in
	"-t")
		host_top100
		exit 0
		;;
	"-i")
		ip_top100
		exit 0
		;;
	"-u")
		URL_top_100
		exit 0
		;;
	"-r")
		respone
		exit 0
		;;
	"-x")
		4xx_URL_top10
		exit 0
		;;
	"-s")
		source_host "$2"
		exit 0
		;;
	"-h")
		help
		exit 0
		;;
esac
done
