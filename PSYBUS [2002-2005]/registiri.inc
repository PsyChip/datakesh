Const GMEM_FIXED=0
Const GMEM_MOVEABLE=2
Const GMEM_ZEROINIT=64
Const GMEM_INVALID_HANDLE=&H8000
Const HKEY_CLASSES_ROOT=&H80000000
Const HKEY_CURRENT_USER=&H80000001
Const HKEY_LOCAL_MACHINE=&H80000002
Const HKEY_USERS=&H80000003
Const HKEY_PERFORMANCE_DATA=&H80000004
Const HKEY_CURRENT_CONFIG=&H80000005
Const HKEY_DYN_DATA=&H80000006
Const REG_OPTION_NON_VOLATILE=0     ' Key is Saved by the Registry.
Const REG_OPTION_VOLATILE=1         ' Key is not Saved by the Registry.
Const KEY_QUERY_VALUE=1
Const KEY_SET_VALUE=2
Const KEY_CREATE_SUB_KEY=4
Const KEY_ENUMERATE_SUB_KEYS=8
Const KEY_NOTIFY=16
Const KEY_CREATE_LINK=32
Const KEY_READ=KEY_QUERY_VALUE OR KEY_ENUMERATE_SUB_KEYS OR KEY_NOTIFY
Const KEY_WRITE=KEY_SET_VALUE OR KEY_CREATE_SUB_KEY
Const KEY_ALL_ACCESS=KEY_QUERY_VALUE OR KEY_ENUMERATE_SUB_KEYS OR KEY_NOTIFY OR KEY_CREATE_SUB_KEY OR KEY_CREATE_LINK OR KEY_SET_VALUE
Const ERROR_SUCCESS=0
Const REG_CREATED_NEW_KEY=1
Const REG_OPENED_EXISTING_KEY=2
Const REG_NONE=0             ' No defined Value Type.
Const REG_SZ=1               ' Unicode/Ansi String.
Const REG_EXPAND_SZ=2        ' Unicode/Ansi Environment-Path String.
Const REG_BINARY=3
Const REG_DWORD=4
Const REG_DWORD_LITTLE_ENDIAN=4  ' 32-bit number
Const REG_DWORD_BIG_ENDIAN=5     ' 32-bit number
Const REG_LINK=6                 ' Symbolic Link (unicode)
Const REG_MULTI_SZ=7             ' Array of Strings, 2 NULLs each String.
Const REG_RESOURCE_LIST=8        ' Device-Drive Resource List.
Const REG_NOTIFY_CHANGE_NAME=1
Const REG_NOTIFY_CHANGE_ATTRIBUTES=2
Const REG_NOTIFY_CHANGE_LAST_SET=4
Const REG_NOTIFY_CHANGE_SECURITY=8
Const WAIT_OBJECT_0=0
Const WAIT_TIMEOUT=&H102
Const WAIT_ABANDONED=128
Const WAIT_FAILED=&HFFFFFFFF
Const INFINITE=&HFFFF
Const ERROR_NO_MORE_ITEMS=259
Const ERROR_MORE_DATA=234

' Registry.BAS CONST Values.
Const WATCH_KEY_ONLY=0
Const WATCH_KEYS_VALUES=1

Declare Function CloseHandle Lib "kernel32.dll" Alias "CloseHandle" (hObject As Long) As Long
Declare Sub CopyMemory Lib "kernel32.dll" Alias "RtlMoveMemory" (ByVal dest As LONG, ByVal source As LONG, ByVal numBytes As LONG)
Declare Function GetLastError Lib "kernel32.dll" Alias "GetLastError" () As Long
Declare Function GlobalAlloc Lib "kernel32.dll" Alias "GlobalAlloc" (flags As Long, numBytes As Long) As Long
Declare Function GlobalFree Lib "kernel32.dll" Alias "GlobalFree" (hMem As Long) As Long
Declare Function GlobalLock Lib "kernel32.dll" Alias "GlobalLock" (hMem As Long) As Long
Declare Function GlobalUnlock Lib "kernel32.dll" Alias "GlobalUnlock" (hMem As Long) As Long
Declare Function RegCloseKey Lib "advapi32.dll" Alias "RegCloseKey" (rootKey As Long) As Long
Declare Function RegOpenKeyEx Lib "advapi32.dll" Alias "RegOpenKeyExA" (rootKey As Long, subKey As String, options As Long, access As Long, status As Long) As Long
Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (rootKey As Long, valueName As String, reserved As Long, valueType As Long, buffer As Long, bufsize As Long) As Long
Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (rootKey As Long, valueName As String, reserved As Long, valueType As Long, valueData As Long, valueSize As Long) As Long

' Registry Variables.
DIM key_Handle AS LONG, key_Status AS LONG, key_Root AS LONG
DIM key_Type AS LONG, compReg_Handle AS LONG, event_Handle AS LONG
DIM mem_Lock AS LONG, mem_Memory AS LONG, mem_Default AS LONG
DIM mem_Offset AS LONG
DIM numSubKeys AS LONG, maxSubKey AS LONG, maxClass AS LONG
DIM numValues AS LONG, maxValueName AS LONG, maxValueData AS LONG
DIM securityLength AS LONG

' Generic Variables.
DIM rtn AS LONG, rtnval AS LONG, stg$ AS STRING, count AS LONG
DIM FLong AS LONG, FWord AS WORD, FByte AS BYTE, FDWord AS LONG
DIM stgs$(0 TO 10) AS STRING, stgbuf$ AS STRING

stgbuf$=STRING$(256, 65)

key_Root = HKEY_CURRENT_USER
key_Handle = 0
key_Status = 0
key_Type = 0
compReg_Handle = 0

SUB UnLock_DefaultMemory
IF mem_Lock<>0 THEN
rtn=GlobalUnlock(mem_Lock)
IF ((rtn=0) AND (GetLastError()=0)) THEN
'MEM UNLOCKED
ELSE
'MEM NOT UNLOCK
END IF
END IF
END SUB

SUB Free_DefaultMemory
IF mem_Memory<>0 THEN
rtn=GlobalFree(mem_Memory)
IF rtn=0 THEN
'MEM FREED
ELSE
'MEM NOT FREED
END IF
END IF
END SUB

SUB Alloc_DefaultMemory(bufsize AS LONG)
mem_Lock=0
mem_Memory=0
mem_Default=0
mem_Memory=GlobalAlloc(GMEM_MOVEABLE OR GMEM_ZEROINIT, bufsize)
IF mem_Memory<>0 THEN
mem_Lock=GlobalLock(mem_Memory)
IF mem_Lock<>0 THEN
mem_Default=mem_Lock

END IF
END IF
END SUB

SUB Reg_OpenKey(key_Name$ AS STRING, accessOptions AS LONG)
rtn=RegOpenKeyEx(key_Root, key_Name$, 0, accessOptions, VarPtr(key_Handle))
IF rtn=ERROR_SUCCESS THEN
'ShowMessage("Key - Opened")
ELSE
'ShowMessage("Key - NOT Opened")
END IF
END SUB

SUB Reg_QueryValue(key_Name$ AS STRING)
IF key_Handle<>0 THEN
rtn=RegQueryValueEx(key_Handle, key_Name$, 0, VarPtr(key_Type), mem_Default, VarPtr(rtnval))
IF rtn=ERROR_SUCCESS THEN
'ShowMessage("Value - Queried")
ELSE
'ShowMessage("QueryValue - Failed")
END IF
END IF
END SUB

' Closes, but does not delete, a SubKey.
SUB Reg_CloseKey
IF key_Handle<>0 THEN
rtn=RegCloseKey(key_Root)
IF rtn=ERROR_SUCCESS THEN
'ShowMessage("Key - Closed")
ELSE
'ShowMessage("CloseKey - Failed")
END IF
END IF
END SUB

Alloc_DefaultMemory(300)