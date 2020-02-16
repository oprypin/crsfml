#include <voidcsfml/system.h>
#include <SFML/System.hpp>
using namespace sf;
void sfml_time_allocate(void** result) {
    *result = malloc(sizeof(Time));
}
void sfml_time_free(void* self) {
    free(self);
}
void sfml_time_initialize(void* self) {
    new(self) Time();
}
void sfml_time_asseconds(void* self, float* result) {
    *(float*)result = ((Time*)self)->asSeconds();
}
void sfml_time_asmilliseconds(void* self, int32_t* result) {
    *(Int32*)result = ((Time*)self)->asMilliseconds();
}
void sfml_time_asmicroseconds(void* self, int64_t* result) {
    *(Int64*)result = ((Time*)self)->asMicroseconds();
}
void sfml_operator_eq_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator==(*(Time*)left, *(Time*)right);
}
void sfml_operator_ne_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator!=(*(Time*)left, *(Time*)right);
}
void sfml_operator_lt_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator<(*(Time*)left, *(Time*)right);
}
void sfml_operator_gt_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator>(*(Time*)left, *(Time*)right);
}
void sfml_operator_le_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator<=(*(Time*)left, *(Time*)right);
}
void sfml_operator_ge_f4Tf4T(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator>=(*(Time*)left, *(Time*)right);
}
void sfml_operator_sub_f4T(void* right, void* result) {
    *(Time*)result = operator-(*(Time*)right);
}
void sfml_operator_add_f4Tf4T(void* left, void* right, void* result) {
    *(Time*)result = operator+(*(Time*)left, *(Time*)right);
}
void sfml_operator_sub_f4Tf4T(void* left, void* right, void* result) {
    *(Time*)result = operator-(*(Time*)left, *(Time*)right);
}
void sfml_operator_mul_f4TBw9(void* left, float right, void* result) {
    *(Time*)result = operator*(*(Time*)left, (float)right);
}
void sfml_operator_mul_f4TG4x(void* left, int64_t right, void* result) {
    *(Time*)result = operator*(*(Time*)left, (Int64)right);
}
void sfml_operator_div_f4TBw9(void* left, float right, void* result) {
    *(Time*)result = operator/(*(Time*)left, (float)right);
}
void sfml_operator_div_f4TG4x(void* left, int64_t right, void* result) {
    *(Time*)result = operator/(*(Time*)left, (Int64)right);
}
void sfml_operator_div_f4Tf4T(void* left, void* right, float* result) {
    *(float*)result = operator/(*(Time*)left, *(Time*)right);
}
void sfml_operator_mod_f4Tf4T(void* left, void* right, void* result) {
    *(Time*)result = operator%(*(Time*)left, *(Time*)right);
}
void sfml_time_initialize_PxG(void* self, void* copy) {
    new(self) Time(*(Time*)copy);
}
void sfml_seconds_Bw9(float amount, void* result) {
    *(Time*)result = seconds((float)amount);
}
void sfml_milliseconds_qe2(int32_t amount, void* result) {
    *(Time*)result = milliseconds((Int32)amount);
}
void sfml_microseconds_G4x(int64_t amount, void* result) {
    *(Time*)result = microseconds((Int64)amount);
}
void sfml_clock_allocate(void** result) {
    *result = malloc(sizeof(Clock));
}
void sfml_clock_finalize(void* self) {
    ((Clock*)self)->~Clock();
}
void sfml_clock_free(void* self) {
    free(self);
}
void sfml_clock_initialize(void* self) {
    new(self) Clock();
}
void sfml_clock_getelapsedtime(void* self, void* result) {
    *(Time*)result = ((Clock*)self)->getElapsedTime();
}
void sfml_clock_restart(void* self, void* result) {
    *(Time*)result = ((Clock*)self)->restart();
}
void sfml_clock_initialize_LuC(void* self, void* copy) {
    new(self) Clock(*(Clock*)copy);
}
void (*_sfml_inputstream_read_callback)(void*, void*, int64_t, int64_t*) = 0;
void sfml_inputstream_read_callback(void (*callback)(void*, void*, int64_t, int64_t*)) {
    _sfml_inputstream_read_callback = callback;
}
void (*_sfml_inputstream_seek_callback)(void*, int64_t, int64_t*) = 0;
void sfml_inputstream_seek_callback(void (*callback)(void*, int64_t, int64_t*)) {
    _sfml_inputstream_seek_callback = callback;
}
void (*_sfml_inputstream_tell_callback)(void*, int64_t*) = 0;
void sfml_inputstream_tell_callback(void (*callback)(void*, int64_t*)) {
    _sfml_inputstream_tell_callback = callback;
}
void (*_sfml_inputstream_getsize_callback)(void*, int64_t*) = 0;
void sfml_inputstream_getsize_callback(void (*callback)(void*, int64_t*)) {
    _sfml_inputstream_getsize_callback = callback;
}
class _InputStream : public sf::InputStream {
public:
    void* parent;
    virtual Int64 read(void* data, Int64 size) {
        Int64 result;
        _sfml_inputstream_read_callback(parent, (void*)data, (int64_t)size, (int64_t*)&result);
        return result;
    }
    virtual Int64 seek(Int64 position) {
        Int64 result;
        _sfml_inputstream_seek_callback(parent, (int64_t)position, (int64_t*)&result);
        return result;
    }
    virtual Int64 tell() {
        Int64 result;
        _sfml_inputstream_tell_callback(parent, (int64_t*)&result);
        return result;
    }
    virtual Int64 getSize() {
        Int64 result;
        _sfml_inputstream_getsize_callback(parent, (int64_t*)&result);
        return result;
    }
};
void sfml_inputstream_parent(void* self, void* parent) {
    ((_InputStream*)self)->parent = parent;
}
void sfml_inputstream_allocate(void** result) {
    *result = malloc(sizeof(_InputStream));
}
void sfml_inputstream_initialize(void* self) {
    new(self) _InputStream();
}
void sfml_inputstream_finalize(void* self) {
    ((_InputStream*)self)->~_InputStream();
}
void sfml_inputstream_free(void* self) {
    free(self);
}
void sfml_inputstream_initialize_mua(void* self, void* copy) {
    new(self) _InputStream(*(_InputStream*)copy);
}
void sfml_noncopyable_allocate(void** result) {
    *result = malloc(sizeof(NonCopyable));
}
void sfml_noncopyable_free(void* self) {
    free(self);
}
void sfml_fileinputstream_allocate(void** result) {
    *result = malloc(sizeof(FileInputStream));
}
void sfml_fileinputstream_free(void* self) {
    free(self);
}
void sfml_fileinputstream_initialize(void* self) {
    new(self) FileInputStream();
}
void sfml_fileinputstream_finalize(void* self) {
    ((FileInputStream*)self)->~FileInputStream();
}
void sfml_fileinputstream_open_zkC(void* self, size_t filename_size, char* filename, unsigned char* result) {
    *(bool*)result = ((FileInputStream*)self)->open(std::string(filename, filename_size));
}
void sfml_fileinputstream_read_xALG4x(void* self, void* data, int64_t size, int64_t* result) {
    *(Int64*)result = ((FileInputStream*)self)->read(data, size);
}
void sfml_fileinputstream_seek_G4x(void* self, int64_t position, int64_t* result) {
    *(Int64*)result = ((FileInputStream*)self)->seek((Int64)position);
}
void sfml_fileinputstream_tell(void* self, int64_t* result) {
    *(Int64*)result = ((FileInputStream*)self)->tell();
}
void sfml_fileinputstream_getsize(void* self, int64_t* result) {
    *(Int64*)result = ((FileInputStream*)self)->getSize();
}
void sfml_memoryinputstream_allocate(void** result) {
    *result = malloc(sizeof(MemoryInputStream));
}
void sfml_memoryinputstream_finalize(void* self) {
    ((MemoryInputStream*)self)->~MemoryInputStream();
}
void sfml_memoryinputstream_free(void* self) {
    free(self);
}
void sfml_memoryinputstream_initialize(void* self) {
    new(self) MemoryInputStream();
}
void sfml_memoryinputstream_open_5h8vgv(void* self, void* data, size_t size_in_bytes) {
    ((MemoryInputStream*)self)->open(data, size_in_bytes);
}
void sfml_memoryinputstream_read_xALG4x(void* self, void* data, int64_t size, int64_t* result) {
    *(Int64*)result = ((MemoryInputStream*)self)->read(data, size);
}
void sfml_memoryinputstream_seek_G4x(void* self, int64_t position, int64_t* result) {
    *(Int64*)result = ((MemoryInputStream*)self)->seek((Int64)position);
}
void sfml_memoryinputstream_tell(void* self, int64_t* result) {
    *(Int64*)result = ((MemoryInputStream*)self)->tell();
}
void sfml_memoryinputstream_getsize(void* self, int64_t* result) {
    *(Int64*)result = ((MemoryInputStream*)self)->getSize();
}
void sfml_memoryinputstream_initialize_kYd(void* self, void* copy) {
    new(self) MemoryInputStream(*(MemoryInputStream*)copy);
}
void sfml_mutex_allocate(void** result) {
    *result = malloc(sizeof(Mutex));
}
void sfml_mutex_free(void* self) {
    free(self);
}
void sfml_mutex_initialize(void* self) {
    new(self) Mutex();
}
void sfml_mutex_finalize(void* self) {
    ((Mutex*)self)->~Mutex();
}
void sfml_mutex_lock(void* self) {
    ((Mutex*)self)->lock();
}
void sfml_mutex_unlock(void* self) {
    ((Mutex*)self)->unlock();
}
void sfml_sleep_f4T(void* duration) {
    sleep(*(Time*)duration);
}
void sfml_thread_allocate(void** result) {
    *result = malloc(sizeof(Thread));
}
void sfml_thread_free(void* self) {
    free(self);
}
void sfml_thread_initialize_XPcbdx(void* self, void (*function)(void*), void* argument) {
    new(self) Thread(function, argument);
}
void sfml_thread_finalize(void* self) {
    ((Thread*)self)->~Thread();
}
void sfml_thread_launch(void* self) {
    ((Thread*)self)->launch();
}
void sfml_thread_wait(void* self) {
    ((Thread*)self)->wait();
}
void sfml_thread_terminate(void* self) {
    ((Thread*)self)->terminate();
}
void sfml_system_version(int* major, int* minor, int* patch) {
    *major = SFML_VERSION_MAJOR;
    *minor = SFML_VERSION_MINOR;
    *patch = SFML_VERSION_PATCH;
}
