#!/usr/bin/env bash
#export PATH=/usr/local/bin:$PATH
      
function help
{
    echo "doc"
    echo "-q Quality       对jpeg格式的图片进行图片质量因子为Q的压缩"
    echo "-r Resolution       对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率"
    echo "-w Free text       对图片批量添加自定义文本水印"
    echo "-p P_text       批量重命名(统一添加文件名前缀,不影响原始文件扩展名)"
    echo "-s S_text       批量重命名(统一添加文件名后缀,不影响原始文件扩展名)"
    echo "-t       支持将png/svg图片统一转换为jpg格式图片"
    echo "-h       帮助文档"
}

# convert filename1 -quality 50 filename2

function image_compress_quality 
{
    for img in *.jpeg; 
    do
        convert "${img}" -quality "$1" "${img}"
        echo "$img is successfully compressed $1."
    done
}

# function : 对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
# Parma: 调整参数

function image_compress_size 
{
    for img in *.jpeg *.png *.svg; 
    do
        convert "$img" -resize "$1" "$img"
        echo "$img is successfully resized."
    done 
}

# function: 对图片批量添加自定义文本水印

# Parma：自定义文本

function watermark 
{
    for img in *; 
    do
        mogrify -pointsize 16 -fill black -weight bolder -gravity southeast -annotate +5+5 "$1" "$img"
        echo "$img is successfully watermarked."
    done
}

# function: 批量添加文件名前缀

# Parma：添加的前缀

function prefix 
{
    for img in *; 
    do
        mv "$img" "$1""$img"
        echo "$img add perfix"
    done

}

# function: 批量添加文件后缀

# Parma：添加的后缀

function suffix 
{
    for img in *;
    do
        mv "$img" "$img""$1"
        echo "$img add suffix"
    done

}

# function:将png/svg图片统一转换为jpg格式图片

function transformed_into_jpeg
{
    for img in *.png *.svg; 
    do
	file=${img%.*}".jpg"
        convert "$img" "${file}"
        echo "$img is transformed into jpg"
    done

}



while [ "$1" != "" ];
do
case "$1" in
    "-q")
        image_compress_quality "$2"
        exit 0
        ;;
    "-r")
        image_compress_size "$2"
        exit 0
        ;;
    "-w")
        watermark "$2" "$3"
        exit 0
        ;;
    "-p")
        prefix "$2"
        exit 0
        ;;
    "-s")
        suffix "$2"
        exit 0
        ;;
    "-t")
        transformed_into_jpeg
        exit 0
        ;;
    "-h")
        help
        exit 0
        ;;
esac
done
