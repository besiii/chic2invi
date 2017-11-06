if test "${CMTROOT}" = ""; then
  CMTROOT=/afs/ihep.ac.cn/bes3/offline/ExternalLib/contrib/CMT/v1r20p20081118; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then tempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=Chic2invi -version=Chic2invi-00-00-01 -path=/besfs/groups/nphy/users/xiaosy/bes/chic2invi/v0.1/analysis/physics/psip $* >${tempfile}; . ${tempfile}
/bin/rm -f ${tempfile}

