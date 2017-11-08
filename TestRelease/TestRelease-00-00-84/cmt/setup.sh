# echo "Setting Jpsi2invi Jpsi2invi-00-00-01 in /afs/ihep.ac.cn/users/x/xiaosy/bes/jpsi2invi/v0.1/Analysis/Physics/PsiPrime"

if test "${CMTROOT}" = ""; then
  CMTROOT=/afs/ihep.ac.cn/bes3/offline/ExternalLib/contrib/CMT/v1r20p20081118; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh

tempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then tempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=TestRelease -version=TestRelease-00-00-84 -path=/afs/ihep.ac.cn/users/x/xiaosy/bes/jpsi2invi/v0.1  -no_cleanup $* >${tempfile}; . ${tempfile}
/bin/rm -f ${tempfile}

