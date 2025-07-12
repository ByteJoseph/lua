#include <iostream>

#ifdef _WIN32
#include <windows.h>
#endif

extern "C" int lua_main(int argc, char** argv);

int main(int argc, char** argv) {
#ifdef _WIN32
    SetConsoleOutputCP(CP_UTF8); 
#endif
if (argc==1)
{ 
    std::cout << u8R"(
╭──────────────────────────────────────────╮
│           Welcome to englang             │
╰──────────────────────────────────────────╯
)" << std::endl;
}else
{
    return lua_main(argc, argv);  
}
return 0;    
}
