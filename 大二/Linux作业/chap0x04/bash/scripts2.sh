#!/usr/bin/env bash


#统计不同年龄区间范围的球员的数量、百分比
function age_range 
{
    awk -F "\t" '
	BEGIN{a=0;b=0;c=0;sum=0}{
		if($6>0&&$6<20)
		{a++}
		else if($6>=20&&$6<=30)
		{b++}
		else
		{c++}
		sum++;
	}
	END{
		printf("age under 20 player: number is %d\t percentage is %.3f%\n",a,a*100/sum);			
		printf("age between 20 to 30 player: number is %d\t percentage is %.3f%\n",b,b*100/sum);
		printf("age over 30 player: number is %d\t percentage is %.3f%\n",c,c*100/sum);
	}' worldcupplayerinfo.tsv
}


#统计不同场上位置的球员数量百分比

function position_range
{
    awk -F "\t" '
	BEGIN{a=0;b=0;c=0;d=0;sum=0}{
		if($5=="Goalie")
		{a++} 
		else if($5=="Defender")
		{b++} 
		else if($5=="Midfielder")
		{c++} 
		else
		{d++}
		sum++;
	}
	END{
		printf("number of Goalie is %d,percentage of Goalie is %.3f%\n",a,a*100/sum);
		printf("number of Defenderb is %d,percentage of Defenderb is %.3f%\n",b,b*100/sum);
		printf("number of Midfielden is %d,percentage of Midfielden is %.3f%\n",c,c*100/sum);
		printf("number of Forward is %d,percentage of Forward is %.3f%\n",d,d*100/sum);
	}' worldcupplayerinfo.tsv
}


#统计名字最长的球员和名字最短的球员

function max_min_name
{
    awk -F "\t" '
	BEGIN{max_len=0;max_name="";min_len=100;min_name=""}{
		if(length($9)>max_len)
		{max_len=length($9);max_name=$9} 
		else if(length($9)<min_len)
		{min_len=length($9);min_name=$9}
	}
	END{
		printf("The longest name: %s\nThe shortest name: %s\n",max_name,min_name);
	}' worldcupplayerinfo.tsv
}


#统计年龄最大和最小的球员

function max_min_age
{
    awk -F "\t" '
	BEGIN{max_age=0;max_name="";min_age=100;min_name=""}{
		if(NR>=2&&$6<=min_age)
		{min_age=$6;min_name=$9} 
		else if(NR>=2&&$6>max_age)
		{max_age=$6;max_name=$9}
	}
	END{
		printf("The oldest player is %s age: %d\n,The youngest player is %s  age: %d\n",max_name,max_age,min_name,min_age)
	}' worldcupplayerinfo.tsv
}


#帮助文档

function help 
{
        echo "HELP INFO:"
        echo "===================================================================================="
        echo "-r       统计不同年龄区间的区间范围（20岁以下、20-30岁，30岁以上）的球员数量、百分比"
        echo "-p       统计不同场上位置的球员数量、百分比"
        echo "-n       统计名字最长的球员和名字最短的球员(字符数统计)"
        echo "-a       统计年龄最大和最小的球员"
        echo "-h                    帮助文档"
}


while [ "$1" != "" ];
do
case "$1" in
            "-r") 
		age_range 
		exit 0
		;;
            "-p")
		position_range 
		exit 0
		;;
            "-n")
		max_min_name 
		exit 0
		;;
            "-a")
		max_min_age 
		exit 0
		;;
            "-h")
                help 
		exit 0
		;;
        esac
    done
