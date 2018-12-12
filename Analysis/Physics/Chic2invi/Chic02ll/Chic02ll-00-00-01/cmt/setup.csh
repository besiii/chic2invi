# echo "Setting Chic02ll Chic02ll-00-00-01 in /afs/ihep.ac.cn/users/a/amitraahul/bes/chic2invi/v0.1/Analysis/Physics/Chic2invi"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /afs/ihep.ac.cn/bes3/offline/ExternalLib/contrib/CMT/v1r20p20081118
endif
source ${CMTROOT}/mgr/setup.csh

set tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set tempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=Chic02ll -version=Chic02ll-00-00-01 -path=/afs/ihep.ac.cn/users/a/amitraahul/bes/chic2invi/v0.1/Analysis/Physics/Chic2invi  -no_cleanup $* >${tempfile}; source ${tempfile}
/bin/rm -f ${tempfile}

