unit VMUtils;

interface

function IsVMwarePresent: LongBool; stdcall;
function IsVPCPresent: boolean; assembler;

implementation

//////////////////////////////////////////////////////////////////////////////// 
// 
//  Simple VMware check on i386 
// 
//    Note: There are plenty ways to detect VMware. This short version bases 
//    on the fact that VMware intercepts IN instructions to port 0x5658 with 
//    an magic value of 0x564D5868 in EAX. However, this is *NOT* officially 
//    documented (used by VMware tools to communicate with the host via VM). 
// 
//    Because this might change in future versions - you should look out for 
//    additional checks (e.g. hardware device IDs, BIOS informations, etc.). 
//    Newer VMware BIOS has valid SMBIOS informations (you might use my BIOS 
//    Helper unit to dump the ROM-BIOS (http://www.bendlins.de/nico/delphi). 
// 

function IsVMwarePresent: LongBool; stdcall;  // platform;
begin 
  Result := False; 
 {$IFDEF CPU386} 
  try 
    asm 
            mov     eax, 564D5868h 
            mov     ebx, 00000000h 
            mov     ecx, 0000000Ah 
            mov     edx, 00005658h 
            in      eax, dx 
            cmp     ebx, 564D5868h 
            jne     @@exit 
            mov     Result, True 
    @@exit: 
    end; 
  except 
    Result := False; 
  end; 
{$ENDIF} 
end; 

{ 
  This function can be used to determine whether your program is 
  running from within Connectrix's Virtual PC 
} 

function IsVPCPresent: boolean; assembler;
asm 
  push ebp 

  mov  ecx, offset @@exception_handler 
  mov  ebp, esp 

  push ebx 
  push ecx 
  push dword ptr fs:[0] 
  mov  dword ptr fs:[0], esp 

  mov  ebx, 0 // flag 
  mov  eax, 1 // VPC function number 

  // call VPC 
  db 00Fh, 03Fh, 007h, 00Bh 

  mov eax, dword ptr ss:[esp] 
  mov dword ptr fs:[0], eax 
  add esp, 8 

  test ebx, ebx 
  setz al 
  lea esp, dword ptr ss:[ebp-4] 
  mov ebx, dword ptr ss:[esp] 
  mov ebp, dword ptr ss:[esp+4] 
  add esp, 8 
  jmp @@ret 
  @@exception_handler: 
  mov ecx, [esp+0Ch] 
  mov dword ptr [ecx+0A4h], -1 // EBX = -1 -> not running, ebx = 0 -> running 
  add dword ptr [ecx+0B8h], 4 // -> skip past the detection code 
  xor eax, eax // exception is handled 
  ret 
  @@ret: 
end; 

end.
 