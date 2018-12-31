// main.cpp
#include <stdio.h>
#include "Structure.h"
#include <iostream>
#include <memory>
#include <thread>
#include <chrono>
#include <mutex>
#include <string>
#include <android/log.h>

#define LOGI(...) \
  ((void)__android_log_print(ANDROID_LOG_INFO, "SharedTest::", __VA_ARGS__))

struct Base
{
    Base() { 
        std::cout << "  Base::Base()\n";
        LOGI("  Base::Base()");
    }
    // Note: non-virtual destructor is OK here
    ~Base() { 
        std::cout << "  Base::~Base()\n"; 
        LOGI("  Base::~Base()");
    }
};
 
struct Derived: public Base
{
    Derived() { 
        std::cout << "  Derived::Derived()\n";
        LOGI("  Derived::Derived()\n");
    }
    ~Derived() {
        std::cout << "  Derived::~Derived()\n";
        LOGI("  Derived::~Derived()\n");
    }
};

void thr(std::shared_ptr<Base> p)
{
    std::this_thread::sleep_for(std::chrono::seconds(1));
    std::shared_ptr<Base> lp = p; // thread-safe, even though the
                                  // shared use_count is incremented
    {
        static std::mutex io_mutex;
        std::lock_guard<std::mutex> lk(io_mutex);
        std::cout << "local pointer in a thread:\n"
                  << "  lp.get() = " << lp.get()
                  << ", lp.use_count() = " << lp.use_count() << '\n';
    }
}

int main() {
    int a = 8;
    int b = 9;
    int c = sum( a, b );
    printf( "sum of %d and %d is %d\n", a, b, c );
    LOGI("sum of %d and %d is %d\n", a, b, c );

    std::cout << "--- single example ---" << std::endl;
    LOGI("--- single example ---");

	std::cout << "==== Check STL =====" <<std::endl;
    LOGI("==== Check STL =====");
    std::shared_ptr<Base> p = std::make_shared<Derived>();
 
    std::cout << "Created a shared Derived (as a pointer to Base)\n"
              << "  p.get() = " << p.get()
              << ", p.use_count() = " << p.use_count() << '\n';
    std::thread t1(thr, p), t2(thr, p), t3(thr, p);
    p.reset(); // release ownership from main
    std::cout << "Shared ownership between 3 threads and released\n"
              << "ownership from main:\n"
              << "  p.get() = " << p.get()
              << ", p.use_count() = " << p.use_count() << '\n';
    t1.join(); t2.join(); t3.join();
    std::cout << "All threads completed, the last one deleted Derived\n";
    LOGI("All threads completed, the last one deleted Derived");


    return 0;
}