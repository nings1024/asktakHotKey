#SingleInstance Force
#Requires AutoHotkey v2.0
#HotIf WinActive("ahk_class SWT_Window0") and StrLen(A_Clipboard) < 500
startsWith(haystack, needle) {
    return RegExMatch(haystack, "^" . needle) == 1
}

::case::
{
    RegExMatch(A_Clipboard, "(9055\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from llcase where caseno='" SubPat[0] "';"
    }
    RegExMatch(A_Clipboard, "(9050\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select l.* from LLCASE l ,LLREPORT l2 WHERE l.CASENO =l2.CASENO AND l2.RPTNO ='" SubPat[0] "';"
    }
}
::report::
{
    RegExMatch(A_Clipboard, "(9055\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from llreport where caseno='" SubPat[0] "';"
    }
    RegExMatch(A_Clipboard, "(9050\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from llreport where rptno='" SubPat[0] "';"
    }
}
::reportsub::
{
    RegExMatch(A_Clipboard, "(9055\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from LLCASERELA l ,LLSUBREPORT l2 WHERE l.SUBRPTNO =l2.SUBRPTNO AND l.CASENO ='" SubPat[0] "';"
    }
    RegExMatch(A_Clipboard, "(9050\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select l.* from LLSUBREPORT l ,LLREPORTRELA l2 WHERE l.SUBRPTNO =l2.SUBRPTNO AND l2.RPTNO ='" SubPat[0] "';"
    }
}
::missb::
{
    RegExMatch(A_Clipboard, "(9055\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select b.ACTIVITYNAME ,a.* from LBMISSION a ,LWACTIVITY b  WHERE MISSIONPROP1 ='"  SubPat[0] "' AND a.ACTIVITYID =b.ACTIVITYID ORDER BY SERIALNO;"
    }
    RegExMatch(A_Clipboard, "(9050\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select b.ACTIVITYNAME ,a.* from LBMISSION a ,LWACTIVITY b  WHERE MISSIONPROP1 ='"  SubPat[0] "' AND a.ACTIVITYID =b.ACTIVITYID ORDER BY SERIALNO;"
    }
}
::missw::
{
    RegExMatch(A_Clipboard, "(9055\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select b.ACTIVITYNAME ,a.* from LWMISSION a ,LWACTIVITY b  WHERE MISSIONPROP1 ='"  SubPat[0] "' AND a.ACTIVITYID =b.ACTIVITYID;"
    }
    RegExMatch(A_Clipboard, "(9050\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select b.ACTIVITYNAME ,a.* from LWMISSION a ,LWACTIVITY b  WHERE MISSIONPROP1 ='"  SubPat[0] "' AND a.ACTIVITYID =b.ACTIVITYID;"
    }
}
::tail::
{
    RegExMatch(A_Clipboard, "(9055\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from LLCLAIMDETAIL l WHERE l.CASENO ='" SubPat[0] "';"
    }
    RegExMatch(A_Clipboard, "(9025\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from LLCLAIMDETAIL l WHERE l.contno ='" SubPat[0] "';"
    }
    RegExMatch(A_Clipboard, "(902[01]\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from LLCLAIMDETAIL l WHERE l.polno ='" SubPat[0] "';"
    }
}
::lup::
{
    txt := A_Clipboard
    txt := Trim(txt)
    if (startsWith(StrLower(txt), 'select')) {
        arrs := StrSplit(txt, 'from', '', 2)
        if arrs.Length>=2
            Send 'update ' arrs[2]
        else{
            arrs := StrSplit(txt, 'FROM', '', 2)
            if arrs.Length>=2
                Send 'update ' arrs[2]
        }
    }
}
::cont::{
    RegExMatch(A_Clipboard, "(9025\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from lccont where contno='" SubPat[0] "';"
    }
}
::bont::{
    RegExMatch(A_Clipboard, "(9025\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from lbcont where contno='" SubPat[0] "';"
    }
}

::polc::{
    RegExMatch(A_Clipboard, "(9025\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select b.RISKNAME,a.polstate,a.POLNO,a.contno,a.CVALIDATE,a.GETSTARTDATE,a.ENDDATE ,a.* from LCPOL a ,LMRISKAPP b WHERE a.RISKCODE =b.RISKCODE AND a.CONTNO ='" SubPat[0] "';"
    }
    RegExMatch(A_Clipboard, "(902[01]\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from lcpol where polno='" SubPat[0] "';"
    }
    
}
::polb::{
    RegExMatch(A_Clipboard, "(9025\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select b.RISKNAME,a.polstate,a.POLNO,a.contno,a.CVALIDATE,a.GETSTARTDATE,a.ENDDATE ,a.* from LbPOL a ,LMRISKAPP b WHERE a.RISKCODE =b.RISKCODE AND a.CONTNO ='" SubPat[0] "';"
    }
    RegExMatch(A_Clipboard, "(902[01]\d{10}88)", &SubPat)
    if (SubPat) {
        Send "select * from lbpol where polno='" SubPat[0] "';"
    }
}
#HotIf
#HotIf WinActive("ahk_class SWT_Window0")
#s:: {
    Send "^9"
    Sleep 300
    Send '长城生产'
    Sleep 500
    Send '{Down}'
    Sleep 100
    Send '{Space}'
    Send '{Enter}'
}

#u:: {
    Send "^9"
    Sleep 300
    Send '长城-uat'
    Sleep 500
    Send '{Down}'
    Sleep 100
    Send '{Space}'
    Send '{Enter}'
}