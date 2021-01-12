#include <windows.h>
BOOL APIENTRY _DllMainCRTStartup (HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpReserved )
{
	return TRUE;
}

__declspec( dllexport ) DWORD __stdcall PtrUShortCall (DWORD_PTR ptr, USHORT num){
    return 1;
}
__declspec( dllexport ) DWORD __stdcall DWORDCall(){
    return 0x80000000;
}