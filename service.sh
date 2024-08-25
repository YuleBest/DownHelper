#!/system/bin/sh
#请不要硬编码/magisk/modname/...;相反，请使用$MODDIR/...
#这将使您的脚本兼容，即使Magisk以后改变挂载点


MODDIR=${0%/*}
LOG=$MODDIR/log.txt
counter=0
config_file=$MODDIR/config.txt

#该脚本将在设备开机后作为延迟服务启动
while true; do
    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 20
    done
    time=$(date +"%Y-%m-%d %H:%M:%S")
    echo "👌[$time] 开机完成，已进入循环" >> $LOG    
  
    #获取变量
    configs="$(cat "$MODDIR/config.conf" | egrep -v '^#')"
	
    #分割变量提纯
    SDIR1=$(echo "$configs" | awk -F '=' '/^SDIR1=/{print $2}')
    SDIR2=$(echo "$configs" | awk -F '=' '/^SDIR2=/{print $2}')
    SDIR3=$(echo "$configs" | awk -F '=' '/^SDIR3=/{print $2}')
    SDIR4=$(echo "$configs" | awk -F '=' '/^SDIR4=/{print $2}')
    SDIR5=$(echo "$configs" | awk -F '=' '/^SDIR5=/{print $2}')
    SDIR6=$(echo "$configs" | awk -F '=' '/^SDIR6=/{print $2}')
    SDIR7=$(echo "$configs" | awk -F '=' '/^SDIR7=/{print $2}')
    SDIR8=$(echo "$configs" | awk -F '=' '/^SDIR8=/{print $2}')
    SDIR9=$(echo "$configs" | awk -F '=' '/^SDIR9=/{print $2}')
    SDIR10=$(echo "$configs" | awk -F '=' '/^SDIR10=/{print $2}')

    TDIR1=$(echo "$configs" | awk -F '=' '/^TDIR1=/{print $2}')
    TDIR2=$(echo "$configs" | awk -F '=' '/^TDIR2=/{print $2}')
    TDIR3=$(echo "$configs" | awk -F '=' '/^TDIR3=/{print $2}')
    TDIR4=$(echo "$configs" | awk -F '=' '/^TDIR4=/{print $2}')
    TDIR5=$(echo "$configs" | awk -F '=' '/^TDIR5=/{print $2}')
    TDIR6=$(echo "$configs" | awk -F '=' '/^TDIR6=/{print $2}')
    TDIR7=$(echo "$configs" | awk -F '=' '/^TDIR7=/{print $2}')
    TDIR8=$(echo "$configs" | awk -F '=' '/^TDIR8=/{print $2}')
    TDIR9=$(echo "$configs" | awk -F '=' '/^TDIR9=/{print $2}')
    TDIR10=$(echo "$configs" | awk -F '=' '/^TDIR10=/{print $2}')
	
    RM1=$(echo "$configs" | awk -F '=' '/^RM1=/{print $2}')
    RM2=$(echo "$configs" | awk -F '=' '/^RM2=/{print $2}')
    RM3=$(echo "$configs" | awk -F '=' '/^RM3=/{print $2}')
    RM4=$(echo "$configs" | awk -F '=' '/^RM4=/{print $2}')
    RM5=$(echo "$configs" | awk -F '=' '/^RM5=/{print $2}')
    RM6=$(echo "$configs" | awk -F '=' '/^RM6=/{print $2}')
	RM7=$(echo "$configs" | awk -F '=' '/^RM7=/{print $2}')
    RM8=$(echo "$configs" | awk -F '=' '/^RM8=/{print $2}')
    RM9=$(echo "$configs" | awk -F '=' '/^RM9=/{print $2}')
	RM10=$(echo "$configs" | awk -F '=' '/^RM10=/{print $2}')
	
	TS=$(echo "$configs" | awk -F '=' '/^TS=/{print $2}')
	
#----------------SDIR1 -> TDIR1---------------------

    #检查TDIR路径是否为空
    if [[ "$TDIR1" != "" ]]; then
        #若TIDR路径不为空
        #检查TIR是否存在
        if [ ! -d "$TDIR1" ]; then
        #若不存在，则创建路径并生成日志
            mkdir -p $TDIR1
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录1] 检测到$TDIR1(目标目录)目录不存在，已创建目录" >> $LOG        
        else    #若存在，则进入下一层判断
            #生成日志
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录1] 检测到$TDIR1(目标目录)目录已存在" >> $LOG
            #检查SDIR路径是否为空
            if [[ "$SDIR1" != "" ]];then
            #若不为空
                #生成日志，后进行下载状态判断
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "👌[$time] [目录1] 检测到$SDIR1(原目录)目录已存在" >> $LOG
                #检查SDIR目录下是否有.tmp文件
                tmp1=$(find $SDIR1 -type f -name '*.tmp')
                if [ -n "$tmp1" ]; then
                    #如果有，生成日志，进入下一次循环
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "❗️[$time] [目录1] 已发现下载中的文件，不进行移动，进入下一次循环
        ----------------------------------------" >> $LOG
                else    #如果没有，则进行文件移动
                    #生成日志
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "👌[$time] [目录1] 未发现下载中的文件，开始移动文件" >> $LOG
                    #获取要移动的文件数量
                    files_to_move=$(ls $SDIR1 | wc -l)       
                    #移动文件
                    mv $SDIR1* $TDIR1
                                       
                    #判断是否删除目录
                    #检查 $RM 是否等于 1
                    if [ "$RM1" -eq 1 ]; then
                        #如果 $RM 等于 1，则删除目录 $SDIR
                        rm -rf "$SDIR1"
                        echo "✅[$time] [目录1] 已为您删除$SDIR1(原目录)"
                    #如果 $RM 不等于 1，则不执行任何操作
                    fi
                    
                    #更新计数器
                    counter=$((counter + files_to_move))
                    title="最新移动位于[目录1]$SDIR1
                    ✅本模块共为您移动了 $counter 个文件！"
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "✅[$time] [目录1] 第$counter个文件移动已完成，计数器更新完毕，进入下一次循环
        ----------------------------------------" >> $LOG
                fi    #下载状态判断结束
            else    #如果SDIR路径为空
                #生成日志
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "🚫[$time] [目录1] 检测到$SDIR1(原目录)路径未填写，跳过移动" >> $LOG
                  
            fi    #SDIR路径是否为空判断结束                
        fi    #TDIR是否存在判断结束
    else    #若TDIR路径为空
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🚫[$time] [目录1] 检测到$TDIR1(目标目录)路径未填写，跳过移动" >> $LOG       
    fi    #TDIR路径是否为空判断完毕
    
#----------------SDIR2 -> TDIR2---------------------

    #检查TDIR路径是否为空
    if [[ "$TDIR2" != "" ]]; then
        #若TIDR路径不为空
        #检查TIR是否存在
        if [ ! -d "$TDIR2" ]; then
        #若不存在，则创建路径并生成日志
            mkdir -p $TDIR2
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录2] 检测到$TDIR2目录不存在，已创建目录" >> $LOG        
        else    #若存在，则进入下一层判断
            #生成日志
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录2] 检测到$TDIR2(目标目录)目录已存在" >> $LOG
            #检查SDIR路径是否为空
            if [[ "$SDIR2" != "" ]];then
            #若不为空
                #生成日志，后进行下载状态判断
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "👌[$time] [目录2] 检测到$SDIR2(原目录)目录已存在" >> $LOG
                #检查SDIR目录下是否有.tmp文件
                tmp2=$(find $SDIR2 -type f -name '*.tmp')
                if [ -n "$tmp2" ]; then
                    #如果有，生成日志，进入下一次循环
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "❗️[$time] [目录2] 已发现下载中的文件，不进行移动，进入下一次循环
        ----------------------------------------" >> $LOG
                else    #如果没有，则进行文件移动
                    #生成日志
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "👌[$time] [目录2] 未发现下载中的文件，开始移动文件" >> $LOG
                    #获取要移动的文件数量
                    files_to_move=$(ls $SDIR2 | wc -l)       
                    #移动文件
                    mv $SDIR2* $TDIR2
                    
                    #判断是否删除目录
                    #检查 $RM 是否等于 1
                    if [ "$RM2" -eq 1 ]; then
                        #如果 $RM 等于 1，则删除目录 $SDIR
                        rm -rf "$SDIR2"
                        echo "✅[$time] [目录2] 已为您删除$SDIR2(原目录)"
                    #如果 $RM 不等于 1，则不执行任何操作
                    fi
                    
                    #更新计数器
                    counter=$((counter + files_to_move))
                    title="最新移动位于[目录2]$SDIR2
                    ✅本模块共为您移动了 $counter 个文件！"
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "✅[$time] [目录2] 第$counter个文件移动已完成，计数器更新完毕，进入下一次循环
        ----------------------------------------" >> $LOG
                fi    #下载状态判断结束
            else    #如果SDIR路径为空
                #生成日志
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "🚫[$time] [目录2] 检测到$SDIR2(原目录)路径未填写，跳过移动" >> $LOG
                  
            fi    #SDIR路径是否为空判断结束                
        fi    #TDIR是否存在判断结束
    else    #若TDIR路径为空
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🚫[$time] [目录2] 检测到$TDIR2(目标目录)路径未填写，跳过移动" >> $LOG       
    fi    #TDIR路径是否为空判断完毕
    
#----------------SDIR3 -> TDIR3---------------------

    #检查TDIR路径是否为空
    if [[ "$TDIR3" != "" ]]; then
        #若TIDR路径不为空
        #检查TIR是否存在
        if [ ! -d "$TDIR3" ]; then
        #若不存在，则创建路径并生成日志
            mkdir -p $TDIR3
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录3] 检测到$TDIR3(目标目录)目录不存在，已创建目录" >> $LOG        
        else    #若存在，则进入下一层判断
            #生成日志
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录3] 检测到$TDIR3(目标目录)目录已存在" >> $LOG
            #检查SDIR路径是否为空
            if [[ "$SDIR3" != "" ]];then
            #若不为空
                #生成日志，后进行下载状态判断
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "👌[$time] [目录3] 检测到$SDIR3(原目录)目录已存在" >> $LOG
                #检查SDIR目录下是否有.tmp文件
                tmp3=$(find $SDIR3 -type f -name '*.tmp')
                if [ -n "$tmp3" ]; then
                    #如果有，生成日志，进入下一次循环
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "❗️[$time] [目录3] 已发现下载中的文件，不进行移动，进入下一次循环
        ----------------------------------------" >> $LOG
                else    #如果没有，则进行文件移动
                    #生成日志
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "👌[$time] [目录3] 未发现下载中的文件，开始移动文件" >> $LOG
                    #获取要移动的文件数量
                    files_to_move=$(ls $SDIR3 | wc -l)       
                    #移动文件
                    mv $SDIR3* $TDIR3
                    
                    #判断是否删除目录
                    #检查 $RM 是否等于 1
                    if [ "$RM3" -eq 1 ]; then
                        #如果 $RM 等于 1，则删除目录 $SDIR
                        rm -rf "$SDIR3"
                        echo "✅[$time] [目录3] 已为您删除$SDIR3(原目录)"
                    #如果 $RM 不等于 1，则不执行任何操作
                    fi
                    
                    #更新计数器
                    counter=$((counter + files_to_move))
                    title="最新移动位于[目录3]$SDIR3
                    ✅本模块共为您移动了 $counter 个文件！"
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "✅[$time] [目录3] 第$counter个文件移动已完成，计数器更新完毕，进入下一次循环
        ----------------------------------------" >> $LOG
                fi    #下载状态判断结束
            else    #如果SDIR路径为空
                #生成日志
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "🚫[$time] [目录3] 检测到$SDIR3(原目录)路径未填写，跳过移动" >> $LOG
                  
            fi    #SDIR路径是否为空判断结束                
        fi    #TDIR是否存在判断结束
    else    #若TDIR路径为空
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🚫[$time] [目录3] 检测到$TDIR3(目标目录)路径未填写，跳过移动" >> $LOG       
    fi    #TDIR路径是否为空判断完毕   

#----------------SDIR4 -> TDIR4---------------------

    #检查TDIR路径是否为空
    if [[ "$TDIR4" != "" ]]; then
        #若TIDR路径不为空
        #检查TIR是否存在
        if [ ! -d "$TDIR4" ]; then
        #若不存在，则创建路径并生成日志
            mkdir -p $TDIR4
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录4] 检测到$TDIR4(目标目录)目录不存在，已创建目录" >> $LOG        
        else    #若存在，则进入下一层判断
            #生成日志
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录4] 检测到$TDIR4(目标目录)目录已存在" >> $LOG
            #检查SDIR路径是否为空
            if [[ "$SDIR4" != "" ]];then
            #若不为空
                #生成日志，后进行下载状态判断
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "👌[$time] [目录4] 检测到$SDIR4(原目录)目录已存在" >> $LOG
                #检查SDIR目录下是否有.tmp文件
                tmp4=$(find $SDIR4 -type f -name '*.tmp')
                if [ -n "$tmp4" ]; then
                    #如果有，生成日志，进入下一次循环
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "❗️[$time] [目录4] 已发现下载中的文件，不进行移动，进入下一次循环
        ----------------------------------------" >> $LOG
                else    #如果没有，则进行文件移动
                    #生成日志
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "👌[$time] [目录4] 未发现下载中的文件，开始移动文件" >> $LOG
                    #获取要移动的文件数量
                    files_to_move=$(ls $SDIR4 | wc -l)       
                    #移动文件
                    mv $SDIR4* $TDIR4
                                       
                    #判断是否删除目录
                    #检查 $RM 是否等于 1
                    if [ "$RM4" -eq 1 ]; then
                        #如果 $RM 等于 1，则删除目录 $SDIR
                        rm -rf "$SDIR4"
                        echo "✅[$time] [目录4] 已为您删除$SDIR4(原目录)"
                    #如果 $RM 不等于 1，则不执行任何操作
                    fi
                    
                    #更新计数器
                    counter=$((counter + files_to_move))
                    title="最新移动位于[目录4]$SDIR4
                    ✅本模块共为您移动了 $counter 个文件！"
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "✅[$time] [目录4] 第$counter个文件移动已完成，计数器更新完毕，进入下一次循环
        ----------------------------------------" >> $LOG
                fi    #下载状态判断结束
            else    #如果SDIR路径为空
                #生成日志
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "🚫[$time] [目录4] 检测到$SDIR4(原目录)路径未填写，跳过移动" >> $LOG
                  
            fi    #SDIR路径是否为空判断结束                
        fi    #TDIR是否存在判断结束
    else    #若TDIR路径为空
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🚫[$time] [目录4] 检测到$TDIR4(目标目录)路径未填写，跳过移动" >> $LOG       
    fi    #TDIR路径是否为空判断完毕
    
#----------------SDIR5 -> TDIR5---------------------

    #检查TDIR路径是否为空
    if [[ "$TDIR5" != "" ]]; then
        #若TIDR路径不为空
        #检查TIR是否存在
        if [ ! -d "$TDIR5" ]; then
        #若不存在，则创建路径并生成日志
            mkdir -p $TDIR5
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录5] 检测到$TDIR5(目标目录)目录不存在，已创建目录" >> $LOG        
        else    #若存在，则进入下一层判断
            #生成日志
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录5] 检测到$TDIR5(目标目录)目录已存在" >> $LOG
            #检查SDIR路径是否为空
            if [[ "$SDIR5" != "" ]];then
            #若不为空
                #生成日志，后进行下载状态判断
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "👌[$time] [目录5] 检测到$SDIR5(原目录)目录已存在" >> $LOG
                #检查SDIR目录下是否有.tmp文件
                tmp5=$(find $SDIR5 -type f -name '*.tmp')
                if [ -n "$tmp5" ]; then
                    #如果有，生成日志，进入下一次循环
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "❗️[$time] [目录5] 已发现下载中的文件，不进行移动，进入下一次循环
        ----------------------------------------" >> $LOG
                else    #如果没有，则进行文件移动
                    #生成日志
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "👌[$time] [目录5] 未发现下载中的文件，开始移动文件" >> $LOG
                    #获取要移动的文件数量
                    files_to_move=$(ls $SDIR5 | wc -l)       
                    #移动文件
                    mv $SDIR5* $TDIR5
                                       
                    #判断是否删除目录
                    #检查 $RM 是否等于 1
                    if [ "$RM5" -eq 1 ]; then
                        #如果 $RM 等于 1，则删除目录 $SDIR
                        rm -rf "$SDIR5"
                        echo "✅[$time] [目录5] 已为您删除$SDIR5(原目录)"
                    #如果 $RM 不等于 1，则不执行任何操作
                    fi
                    
                    #更新计数器
                    counter=$((counter + files_to_move))
                    title="最新移动位于[目录5]$SDIR5
                    ✅本模块共为您移动了 $counter 个文件！"
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "✅[$time] [目录5] 第$counter个文件移动已完成，计数器更新完毕，进入下一次循环
        ----------------------------------------" >> $LOG
                fi    #下载状态判断结束
            else    #如果SDIR路径为空
                #生成日志
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "🚫[$time] [目录5] 检测到$SDIR5(原目录)路径未填写，跳过移动" >> $LOG
                  
            fi    #SDIR路径是否为空判断结束                
        fi    #TDIR是否存在判断结束
    else    #若TDIR路径为空
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🚫[$time] [目录5] 检测到$TDIR5(目标目录)路径未填写，跳过移动" >> $LOG       
    fi    #TDIR路径是否为空判断完毕

#----------------SDIR6 -> TDIR6---------------------

    #检查TDIR路径是否为空
    if [[ "$TDIR6" != "" ]]; then
        #若TIDR路径不为空
        #检查TIR是否存在
        if [ ! -d "$TDIR6" ]; then
        #若不存在，则创建路径并生成日志
            mkdir -p $TDIR6
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录6] 检测到$TDIR6(目标目录)目录不存在，已创建目录" >> $LOG        
        else    #若存在，则进入下一层判断
            #生成日志
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录6] 检测到$TDIR6(目标目录)目录已存在" >> $LOG
            #检查SDIR路径是否为空
            if [[ "$SDIR6" != "" ]];then
            #若不为空
                #生成日志，后进行下载状态判断
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "👌[$time] [目录6] 检测到$SDIR6(原目录)目录已存在" >> $LOG
                #检查SDIR目录下是否有.tmp文件
                tmp6=$(find $SDIR6 -type f -name '*.tmp')
                if [ -n "$tmp6" ]; then
                    #如果有，生成日志，进入下一次循环
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "❗️[$time] [目录6] 已发现下载中的文件，不进行移动，进入下一次循环
        ----------------------------------------" >> $LOG
                else    #如果没有，则进行文件移动
                    #生成日志
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "👌[$time] [目录6] 未发现下载中的文件，开始移动文件" >> $LOG
                    #获取要移动的文件数量
                    files_to_move=$(ls $SDIR6 | wc -l)       
                    #移动文件
                    mv $SDIR6* $TDIR6
                                       
                    #判断是否删除目录
                    #检查 $RM 是否等于 1
                    if [ "$RM6" -eq 1 ]; then
                        #如果 $RM 等于 1，则删除目录 $SDIR
                        rm -rf "$SDIR6"
                        echo "✅[$time] [目录6] 已为您删除$SDIR6(原目录)"
                    #如果 $RM 不等于 1，则不执行任何操作
                    fi
                    
                    #更新计数器
                    counter=$((counter + files_to_move))
                    title="最新移动位于[目录6]$SDIR6
                    ✅本模块共为您移动了 $counter 个文件！"
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "✅[$time] [目录6] 第$counter个文件移动已完成，计数器更新完毕，进入下一次循环
        ----------------------------------------" >> $LOG
                fi    #下载状态判断结束
            else    #如果SDIR路径为空
                #生成日志
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "🚫[$time] [目录6] 检测到$SDIR6(原目录)路径未填写，跳过移动" >> $LOG
                  
            fi    #SDIR路径是否为空判断结束                
        fi    #TDIR是否存在判断结束
    else    #若TDIR路径为空
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🚫[$time] [目录6] 检测到$TDIR6(目标目录)路径未填写，跳过移动" >> $LOG       
    fi    #TDIR路径是否为空判断完毕

#----------------SDIR7 -> TDIR7---------------------

    #检查TDIR路径是否为空
    if [[ "$TDIR7" != "" ]]; then
        #若TIDR路径不为空
        #检查TIR是否存在
        if [ ! -d "$TDIR7" ]; then
        #若不存在，则创建路径并生成日志
            mkdir -p $TDIR7
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录7] 检测到$TDIR7(目标目录)目录不存在，已创建目录" >> $LOG        
        else    #若存在，则进入下一层判断
            #生成日志
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录7] 检测到$TDIR7(目标目录)目录已存在" >> $LOG
            #检查SDIR路径是否为空
            if [[ "$SDIR7" != "" ]];then
            #若不为空
                #生成日志，后进行下载状态判断
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "👌[$time] [目录7] 检测到$SDIR7(原目录)目录已存在" >> $LOG
                #检查SDIR目录下是否有.tmp文件
                tmp7=$(find $SDIR7 -type f -name '*.tmp')
                if [ -n "$tmp7" ]; then
                    #如果有，生成日志，进入下一次循环
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "❗️[$time] [目录7] 已发现下载中的文件，不进行移动，进入下一次循环
        ----------------------------------------" >> $LOG
                else    #如果没有，则进行文件移动
                    #生成日志
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "👌[$time] [目录7] 未发现下载中的文件，开始移动文件" >> $LOG
                    #获取要移动的文件数量
                    files_to_move=$(ls $SDIR7 | wc -l)       
                    #移动文件
                    mv $SDIR7* $TDIR7
                                       
                    #判断是否删除目录
                    #检查 $RM 是否等于 1
                    if [ "$RM7" -eq 1 ]; then
                        #如果 $RM 等于 1，则删除目录 $SDIR
                        rm -rf "$SDIR7"
                        echo "✅[$time] [目录7] 已为您删除$SDIR7(原目录)"
                    #如果 $RM 不等于 1，则不执行任何操作
                    fi
                    
                    #更新计数器
                    counter=$((counter + files_to_move))
                    title="最新移动位于[目录7]$SDIR7
                    ✅本模块共为您移动了 $counter 个文件！"
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "✅[$time] [目录7] 第$counter个文件移动已完成，计数器更新完毕，进入下一次循环
        ----------------------------------------" >> $LOG
                fi    #下载状态判断结束
            else    #如果SDIR路径为空
                #生成日志
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "🚫[$time] [目录7] 检测到$SDIR7(原目录)路径未填写，跳过移动" >> $LOG
                  
            fi    #SDIR路径是否为空判断结束                
        fi    #TDIR是否存在判断结束
    else    #若TDIR路径为空
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🚫[$time] [目录7] 检测到$TDIR7(目标目录)路径未填写，跳过移动" >> $LOG       
    fi    #TDIR路径是否为空判断完毕

#----------------SDIR6 -> TDIR6---------------------

    #检查TDIR路径是否为空
    if [[ "$TDIR6" != "" ]]; then
        #若TIDR路径不为空
        #检查TIR是否存在
        if [ ! -d "$TDIR6" ]; then
        #若不存在，则创建路径并生成日志
            mkdir -p $TDIR6
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录6] 检测到$TDIR6(目标目录)目录不存在，已创建目录" >> $LOG        
        else    #若存在，则进入下一层判断
            #生成日志
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录6] 检测到$TDIR6(目标目录)目录已存在" >> $LOG
            #检查SDIR路径是否为空
            if [[ "$SDIR6" != "" ]];then
            #若不为空
                #生成日志，后进行下载状态判断
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "👌[$time] [目录6] 检测到$SDIR6(原目录)目录已存在" >> $LOG
                #检查SDIR目录下是否有.tmp文件
                tmp6=$(find $SDIR6 -type f -name '*.tmp')
                if [ -n "$tmp6" ]; then
                    #如果有，生成日志，进入下一次循环
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "❗️[$time] [目录6] 已发现下载中的文件，不进行移动，进入下一次循环
        ----------------------------------------" >> $LOG
                else    #如果没有，则进行文件移动
                    #生成日志
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "👌[$time] [目录6] 未发现下载中的文件，开始移动文件" >> $LOG
                    #获取要移动的文件数量
                    files_to_move=$(ls $SDIR6 | wc -l)       
                    #移动文件
                    mv $SDIR6* $TDIR6
                                       
                    #判断是否删除目录
                    #检查 $RM 是否等于 1
                    if [ "$RM6" -eq 1 ]; then
                        #如果 $RM 等于 1，则删除目录 $SDIR
                        rm -rf "$SDIR6"
                        echo "✅[$time] [目录6] 已为您删除$SDIR6(原目录)"
                    #如果 $RM 不等于 1，则不执行任何操作
                    fi
                    
                    #更新计数器
                    counter=$((counter + files_to_move))
                    title="最新移动位于[目录6]$SDIR6
                    ✅本模块共为您移动了 $counter 个文件！"
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "✅[$time] [目录6] 第$counter个文件移动已完成，计数器更新完毕，进入下一次循环
        ----------------------------------------" >> $LOG
                fi    #下载状态判断结束
            else    #如果SDIR路径为空
                #生成日志
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "🚫[$time] [目录6] 检测到$SDIR6(原目录)路径未填写，跳过移动" >> $LOG
                  
            fi    #SDIR路径是否为空判断结束                
        fi    #TDIR是否存在判断结束
    else    #若TDIR路径为空
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🚫[$time] [目录6] 检测到$TDIR6(目标目录)路径未填写，跳过移动" >> $LOG       
    fi    #TDIR路径是否为空判断完毕

#----------------SDIR9 -> TDIR9---------------------

    #检查TDIR路径是否为空
    if [[ "$TDIR9" != "" ]]; then
        #若TIDR路径不为空
        #检查TIR是否存在
        if [ ! -d "$TDIR9" ]; then
        #若不存在，则创建路径并生成日志
            mkdir -p $TDIR9
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录9] 检测到$TDIR9(目标目录)目录不存在，已创建目录" >> $LOG        
        else    #若存在，则进入下一层判断
            #生成日志
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录9] 检测到$TDIR9(目标目录)目录已存在" >> $LOG
            #检查SDIR路径是否为空
            if [[ "$SDIR9" != "" ]];then
            #若不为空
                #生成日志，后进行下载状态判断
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "👌[$time] [目录9] 检测到$SDIR9(原目录)目录已存在" >> $LOG
                #检查SDIR目录下是否有.tmp文件
                tmp9=$(find $SDIR9 -type f -name '*.tmp')
                if [ -n "$tmp9" ]; then
                    #如果有，生成日志，进入下一次循环
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "❗️[$time] [目录9] 已发现下载中的文件，不进行移动，进入下一次循环
        ----------------------------------------" >> $LOG
                else    #如果没有，则进行文件移动
                    #生成日志
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "👌[$time] [目录9] 未发现下载中的文件，开始移动文件" >> $LOG
                    #获取要移动的文件数量
                    files_to_move=$(ls $SDIR9 | wc -l)       
                    #移动文件
                    mv $SDIR9* $TDIR9
                                       
                    #判断是否删除目录
                    #检查 $RM 是否等于 1
                    if [ "$RM9" -eq 1 ]; then
                        #如果 $RM 等于 1，则删除目录 $SDIR
                        rm -rf "$SDIR9"
                        echo "✅[$time] [目录9] 已为您删除$SDIR9(原目录)"
                    #如果 $RM 不等于 1，则不执行任何操作
                    fi
                    
                    #更新计数器
                    counter=$((counter + files_to_move))
                    title="最新移动位于[目录9]$SDIR9
                    ✅本模块共为您移动了 $counter 个文件！"
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "✅[$time] [目录9] 第$counter个文件移动已完成，计数器更新完毕，进入下一次循环
        ----------------------------------------" >> $LOG
                fi    #下载状态判断结束
            else    #如果SDIR路径为空
                #生成日志
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "🚫[$time] [目录9] 检测到$SDIR9(原目录)路径未填写，跳过移动" >> $LOG
                  
            fi    #SDIR路径是否为空判断结束                
        fi    #TDIR是否存在判断结束
    else    #若TDIR路径为空
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🚫[$time] [目录9] 检测到$TDIR9(目标目录)路径未填写，跳过移动" >> $LOG       
    fi    #TDIR路径是否为空判断完毕

#----------------SDIR10 -> TDIR10---------------------

    #检查TDIR路径是否为空
    if [[ "$TDIR10" != "" ]]; then
        #若TIDR路径不为空
        #检查TIR是否存在
        if [ ! -d "$TDIR10" ]; then
        #若不存在，则创建路径并生成日志
            mkdir -p $TDIR10
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录10] 检测到$TDIR10(目标目录)目录不存在，已创建目录" >> $LOG        
        else    #若存在，则进入下一层判断
            #生成日志
            time=$(date +"%Y-%m-%d %H:%M:%S")
            echo "👌[$time] [目录10] 检测到$TDIR10(目标目录)目录已存在" >> $LOG
            #检查SDIR路径是否为空
            if [[ "$SDIR10" != "" ]];then
            #若不为空
                #生成日志，后进行下载状态判断
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "👌[$time] [目录10] 检测到$SDIR10(原目录)目录已存在" >> $LOG
                #检查SDIR目录下是否有.tmp文件
                tmp10=$(find $SDIR10 -type f -name '*.tmp')
                if [ -n "$tmp10" ]; then
                    #如果有，生成日志，进入下一次循环
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "❗️[$time] [目录10] 已发现下载中的文件，不进行移动，进入下一次循环
        ----------------------------------------" >> $LOG
                else    #如果没有，则进行文件移动
                    #生成日志
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "👌[$time] [目录10] 未发现下载中的文件，开始移动文件" >> $LOG
                    #获取要移动的文件数量
                    files_to_move=$(ls $SDIR10 | wc -l)       
                    #移动文件
                    mv $SDIR10* $TDIR10
                                       
                    #判断是否删除目录
                    #检查 $RM 是否等于 1
                    if [ "$RM10" -eq 1 ]; then
                        #如果 $RM 等于 1，则删除目录 $SDIR
                        rm -rf "$SDIR10"
                        echo "✅[$time] [目录10] 已为您删除$SDIR10(原目录)"
                    #如果 $RM 不等于 1，则不执行任何操作
                    fi
                    
                    #更新计数器
                    counter=$((counter + files_to_move))
                    title="最新移动位于[目录10]$SDIR10
                    ✅本模块共为您移动了 $counter 个文件！"
                    time=$(date +"%Y-%m-%d %H:%M:%S")
                    echo "✅[$time] [目录10] 第$counter个文件移动已完成，计数器更新完毕，进入下一次循环
        ----------------------------------------" >> $LOG
                fi    #下载状态判断结束
            else    #如果SDIR路径为空
                #生成日志
                time=$(date +"%Y-%m-%d %H:%M:%S")
                echo "🚫[$time] [目录10] 检测到$SDIR10(原目录)路径未填写，跳过移动" >> $LOG
                  
            fi    #SDIR路径是否为空判断结束                
        fi    #TDIR是否存在判断结束
    else    #若TDIR路径为空
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🚫[$time] [目录10] 检测到$TDIR10(目标目录)路径未填写，跳过移动" >> $LOG       
    fi    #TDIR路径是否为空判断完毕

#----------------一轮文件移动完成---------------------      
 
    #更新计数器
    sed -i '/^description=/d' $MODDIR/module.prop
    echo "description=${title}" >>$MODDIR/module.prop
    
    #删日志
    #获取日志的行数
    line_count=$(wc -l < $LOG)
    #检查行数是否超过1024
    if [ $line_count -gt 10000 ]; then
        #删除前128行
        awk 'NR>1000' $LOG > $MODDIR/temp.txt && mv $MODDIR/temp.txt $LOG
        time=$(date +"%Y-%m-%d %H:%M:%S")
        echo "🔪[$time] 日志已满10000行，自动删除前1000行" >> $LOG
    fi
    
    
    #睡眠5秒
    sleep $TS
done
