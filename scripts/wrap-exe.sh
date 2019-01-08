#!/bin/bash

#
# 封装 exe,使其能在 Linux 中可执行
#

app_dir="$(cd `dirname $0` && pwd -P)"
exe_files=$(find "$app_dir/package.nw" -name "*.exe" -not -path "*node_modules*")
for exe_file in ${exe_files[@]}; do
    exe_dirname="$(dirname $exe_file)"
    exe_basename="$(basename $exe_file)"
    if [[ $exe_basename =~ ^__.*$ ]]; then
        continue
    fi
    exe_newfile="$exe_dirname/__$exe_basename"
    if [ ! -f $exe_newfile ]; then
        mv $exe_file $exe_newfile
    fi
    cat > $exe_file <<EOF
#!/bin/bash

env LC_ALL=zh_CN.UTF-8 wine $exe_newfile "\$@"
EOF
    chmod +x $exe_file
done