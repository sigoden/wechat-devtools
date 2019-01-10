#!/bin/bash

#
# 封装 exe,使其能在 Linux 中可执行
#

app_dir="$(cd `dirname $0` && pwd -P)"
exe_files=$(cd "$app_dir" && find package.nw -name "*.exe" -not -path "*node_modules*")
for exe_file in ${exe_files[@]}; do
    exe_file_fullpath="$app_dir/$exe_file"
    exe_dirname="$(dirname $exe_file)"
    exe_basename="$(basename $exe_file)"
    if [[ "$exe_basename" =~ ^__.*$ ]]; then
        continue
    fi
    exe_newfile="$exe_dirname/__$exe_basename"
    exe_newfile_fullpath="$app_dir/$exe_newfile"
    if [ ! -f "$exe_newfile_fullpath" ]; then
        mv $exe_file_fullpath $exe_newfile_fullpath
    fi
    cat > $exe_file_fullpath <<EOF
#!/bin/bash

env LC_ALL=zh_CN.UTF-8 wine \$WECHAT_DEVTOOLS_DIR/$exe_newfile "\$@"
EOF
    chmod +x $exe_file_fullpath
done