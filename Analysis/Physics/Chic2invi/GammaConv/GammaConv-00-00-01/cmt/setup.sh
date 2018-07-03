# echo "Setting GammaConv GammaConv-00-00-04 in /workfs/bes/zhangjielei/workarea664p03"

if test "${CMTROOT}" = ""; then
  CMTROOT=/afs/ihep.ac.cn/bes3/offline/ExternalLib/contrib/CMT/v1r20p20081118; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh

tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then tempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=GammaConv -version=GammaConv-00-00-01 -path=/afs/ihep.ac.cn/users/x/xiaosy/bes/chic2invi/v0.1/Analysis/Physics/Chic2invi/GammaConv/GammaConv-00-00-01/cmt  -no_cleanup $* >${tempfile}; . ${tempfile}
/bin/rm -f ${tempfile}

