

# $1 file $2 url  $3 sha256
function check_and_get_source_package()
{
    if [ ! -f "$1" ]; then
        wget $2
    else
        this_sha256=$(sha256sum $1 | awk '{print $1}')
        if [ $this_sha256 != $3 ];then
            rm $1
            wget $2
        fi
    fi
}

# $1 file $2 director
function check_and_unpackage_source()
{
    if [ ! -d $2 ];then
        tar xvf $1
    fi
}
