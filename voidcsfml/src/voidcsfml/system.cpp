#include <voidcsfml/system.h>
#include <SFML/System.hpp>
using namespace sf;
void time_initialize(void* self) {
    new(self) Time();
}
void time_asseconds(void* self, float* result) {
    *(float*)result = ((Time*)self)->asSeconds();
}
void time_asmilliseconds(void* self, int32_t* result) {
    *(Int32*)result = ((Time*)self)->asMilliseconds();
}
void time_asmicroseconds(void* self, int64_t* result) {
    *(Int64*)result = ((Time*)self)->asMicroseconds();
}
void operator_eq_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator==(*(Time*)left, *(Time*)right);
}
void operator_ne_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator!=(*(Time*)left, *(Time*)right);
}
void operator_lt_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator<(*(Time*)left, *(Time*)right);
}
void operator_gt_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator>(*(Time*)left, *(Time*)right);
}
void operator_le_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator<=(*(Time*)left, *(Time*)right);
}
void operator_ge_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator>=(*(Time*)left, *(Time*)right);
}
void operator_sub_f4T(void* right, void* result) {
    *(Time*)result = operator-(*(Time*)right);
}
void operator_add_f4Tf4T(void* left, void* right, void* result) {
    *(Time*)result = operator+(*(Time*)left, *(Time*)right);
}
void operator_sub_f4Tf4T(void* left, void* right, void* result) {
    *(Time*)result = operator-(*(Time*)left, *(Time*)right);
}
void operator_mul_f4TBw9(void* left, float right, void* result) {
    *(Time*)result = operator*(*(Time*)left, (float)right);
}
void operator_mul_f4TG4x(void* left, int64_t right, void* result) {
    *(Time*)result = operator*(*(Time*)left, (Int64)right);
}
void operator_div_f4TBw9(void* left, float right, void* result) {
    *(Time*)result = operator/(*(Time*)left, (float)right);
}
void operator_div_f4TG4x(void* left, int64_t right, void* result) {
    *(Time*)result = operator/(*(Time*)left, (Int64)right);
}
void operator_div_f4Tf4T(void* left, void* right, float* result) {
    *(float*)result = operator/(*(Time*)left, *(Time*)right);
}
void operator_mod_f4Tf4T(void* left, void* right, void* result) {
    *(Time*)result = operator%(*(Time*)left, *(Time*)right);
}
void time_initialize_PxG(void* self, void* copy) {
    new(self) Time(*(Time*)copy);
}
void seconds_Bw9(float amount, void* result) {
    *(Time*)result = seconds((float)amount);
}
void milliseconds_qe2(int32_t amount, void* result) {
    *(Time*)result = milliseconds((Int32)amount);
}
void microseconds_G4x(int64_t amount, void* result) {
    *(Time*)result = microseconds((Int64)amount);
}
void clock_initialize(void* self) {
    new(self) Clock();
}
void clock_getelapsedtime(void* self, void* result) {
    *(Time*)result = ((Clock*)self)->getElapsedTime();
}
void clock_restart(void* self, void* result) {
    *(Time*)result = ((Clock*)self)->restart();
}
void clock_initialize_LuC(void* self, void* copy) {
    new(self) Clock(*(Clock*)copy);
}
class _InputStream : public sf::InputStream {
public:
    virtual Int64 read(void* data, Int64 size) {
        Int64 result;
        inputstream_read_callback((void*)this, (void*)data, (int64_t)size, (int64_t*)&result);
        return result;
    }
    virtual Int64 seek(Int64 position) {
        Int64 result;
        inputstream_seek_callback((void*)this, (int64_t)position, (int64_t*)&result);
        return result;
    }
    virtual Int64 tell() {
        Int64 result;
        inputstream_tell_callback((void*)this, (int64_t*)&result);
        return result;
    }
    virtual Int64 getSize() {
        Int64 result;
        inputstream_getsize_callback((void*)this, (int64_t*)&result);
        return result;
    }
};
void (*inputstream_read_callback)(void*, void*, int64_t, int64_t*) = 0;
void (*inputstream_seek_callback)(void*, int64_t, int64_t*) = 0;
void (*inputstream_tell_callback)(void*, int64_t*) = 0;
void (*inputstream_getsize_callback)(void*, int64_t*) = 0;
void inputstream_initialize(void* self) {
    new(self) _InputStream();
}
void inputstream_initialize_mua(void* self, void* copy) {
    new(self) _InputStream(*(_InputStream*)copy);
}
void fileinputstream_initialize(void* self) {
    new(self) FileInputStream();
}
void fileinputstream_finalize(void* self) {
    ((FileInputStream*)self)->~FileInputStream();
}
void fileinputstream_open_zkC(void* self, size_t filename_size, char* filename, unsigned char* result) {
    *(bool*)result = ((FileInputStream*)self)->open(std::string(filename, filename_size));
}
void fileinputstream_read_xALG4x(void* self, void* data, int64_t size, int64_t* result) {
    *(Int64*)result = ((FileInputStream*)self)->read(data, size);
}
void fileinputstream_seek_G4x(void* self, int64_t position, int64_t* result) {
    *(Int64*)result = ((FileInputStream*)self)->seek((Int64)position);
}
void fileinputstream_tell(void* self, int64_t* result) {
    *(Int64*)result = ((FileInputStream*)self)->tell();
}
void fileinputstream_getsize(void* self, int64_t* result) {
    *(Int64*)result = ((FileInputStream*)self)->getSize();
}
void memoryinputstream_initialize(void* self) {
    new(self) MemoryInputStream();
}
void memoryinputstream_open_5h8vgv(void* self, void* data, size_t size_in_bytes) {
    ((MemoryInputStream*)self)->open(data, size_in_bytes);
}
void memoryinputstream_read_xALG4x(void* self, void* data, int64_t size, int64_t* result) {
    *(Int64*)result = ((MemoryInputStream*)self)->read(data, size);
}
void memoryinputstream_seek_G4x(void* self, int64_t position, int64_t* result) {
    *(Int64*)result = ((MemoryInputStream*)self)->seek((Int64)position);
}
void memoryinputstream_tell(void* self, int64_t* result) {
    *(Int64*)result = ((MemoryInputStream*)self)->tell();
}
void memoryinputstream_getsize(void* self, int64_t* result) {
    *(Int64*)result = ((MemoryInputStream*)self)->getSize();
}
void memoryinputstream_initialize_kYd(void* self, void* copy) {
    new(self) MemoryInputStream(*(MemoryInputStream*)copy);
}
void mutex_initialize(void* self) {
    new(self) Mutex();
}
void mutex_finalize(void* self) {
    ((Mutex*)self)->~Mutex();
}
void mutex_lock(void* self) {
    ((Mutex*)self)->lock();
}
void mutex_unlock(void* self) {
    ((Mutex*)self)->unlock();
}
void sleep_f4T(void* duration) {
    sleep(*(Time*)duration);
}
void thread_initialize_XPcbdx(void* self, void (*function)(void*), void* argument) {
    new(self) Thread(function, argument);
}
void thread_finalize(void* self) {
    ((Thread*)self)->~Thread();
}
void thread_launch(void* self) {
    ((Thread*)self)->launch();
}
void thread_wait(void* self) {
    ((Thread*)self)->wait();
}
void thread_terminate(void* self) {
    ((Thread*)self)->terminate();
}
void sfml_system_version(int* major, int* minor, int* patch) {
    *major = SFML_VERSION_MAJOR;
    *minor = SFML_VERSION_MINOR;
    *patch = SFML_VERSION_PATCH;
}
