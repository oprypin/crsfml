#include <SFML/Audio.hpp>
#include <SFML/System.hpp>
using namespace sf;
extern "C" {
void sfml_listener_allocate(void** result) {
    *result = malloc(sizeof(Listener));
}
void sfml_listener_free(void* self) {
    free(self);
}
void sfml_listener_setglobalvolume_Bw9(float volume) {
    Listener::setGlobalVolume(volume);
}
void sfml_listener_getglobalvolume(float* result) {
    *(float*)result = Listener::getGlobalVolume();
}
void sfml_listener_setposition_Bw9Bw9Bw9(float x, float y, float z) {
    Listener::setPosition(x, y, z);
}
void sfml_listener_setposition_NzM(void* position) {
    Listener::setPosition(*(Vector3f*)position);
}
void sfml_listener_getposition(void* result) {
    *(Vector3f*)result = Listener::getPosition();
}
void sfml_listener_setdirection_Bw9Bw9Bw9(float x, float y, float z) {
    Listener::setDirection(x, y, z);
}
void sfml_listener_setdirection_NzM(void* direction) {
    Listener::setDirection(*(Vector3f*)direction);
}
void sfml_listener_getdirection(void* result) {
    *(Vector3f*)result = Listener::getDirection();
}
void sfml_listener_setupvector_Bw9Bw9Bw9(float x, float y, float z) {
    Listener::setUpVector(x, y, z);
}
void sfml_listener_setupvector_NzM(void* up_vector) {
    Listener::setUpVector(*(Vector3f*)up_vector);
}
void sfml_listener_getupvector(void* result) {
    *(Vector3f*)result = Listener::getUpVector();
}
void sfml_alresource_allocate(void** result) {
    *result = malloc(sizeof(AlResource));
}
void sfml_alresource_free(void* self) {
    free(self);
}
void (*_sfml_soundsource_play_callback)(void*) = 0;
void sfml_soundsource_play_callback(void (*callback)(void*)) {
    _sfml_soundsource_play_callback = callback;
}
void (*_sfml_soundsource_pause_callback)(void*) = 0;
void sfml_soundsource_pause_callback(void (*callback)(void*)) {
    _sfml_soundsource_pause_callback = callback;
}
void (*_sfml_soundsource_stop_callback)(void*) = 0;
void sfml_soundsource_stop_callback(void (*callback)(void*)) {
    _sfml_soundsource_stop_callback = callback;
}
class _SoundSource : public sf::SoundSource {
public:
    void* parent;
    virtual void play() {
        _sfml_soundsource_play_callback(parent);
    }
    virtual void pause() {
        _sfml_soundsource_pause_callback(parent);
    }
    virtual void stop() {
        _sfml_soundsource_stop_callback(parent);
    }
};
void sfml_soundsource_parent(void* self, void* parent) {
    ((_SoundSource*)self)->parent = parent;
}
void sfml_soundsource_allocate(void** result) {
    *result = malloc(sizeof(_SoundSource));
}
void sfml_soundsource_free(void* self) {
    free(self);
}
void sfml_soundsource_finalize(void* self) {
    ((_SoundSource*)self)->~_SoundSource();
}
void sfml_soundsource_setpitch_Bw9(void* self, float pitch) {
    ((_SoundSource*)self)->setPitch(pitch);
}
void sfml_soundsource_setvolume_Bw9(void* self, float volume) {
    ((_SoundSource*)self)->setVolume(volume);
}
void sfml_soundsource_setposition_Bw9Bw9Bw9(void* self, float x, float y, float z) {
    ((_SoundSource*)self)->setPosition(x, y, z);
}
void sfml_soundsource_setposition_NzM(void* self, void* position) {
    ((_SoundSource*)self)->setPosition(*(Vector3f*)position);
}
void sfml_soundsource_setrelativetolistener_GZq(void* self, Int8 relative) {
    ((_SoundSource*)self)->setRelativeToListener(relative != 0);
}
void sfml_soundsource_setmindistance_Bw9(void* self, float distance) {
    ((_SoundSource*)self)->setMinDistance(distance);
}
void sfml_soundsource_setattenuation_Bw9(void* self, float attenuation) {
    ((_SoundSource*)self)->setAttenuation(attenuation);
}
void sfml_soundsource_getpitch(void* self, float* result) {
    *(float*)result = ((_SoundSource*)self)->getPitch();
}
void sfml_soundsource_getvolume(void* self, float* result) {
    *(float*)result = ((_SoundSource*)self)->getVolume();
}
void sfml_soundsource_getposition(void* self, void* result) {
    *(Vector3f*)result = ((_SoundSource*)self)->getPosition();
}
void sfml_soundsource_isrelativetolistener(void* self, Int8* result) {
    *(bool*)result = ((_SoundSource*)self)->isRelativeToListener();
}
void sfml_soundsource_getmindistance(void* self, float* result) {
    *(float*)result = ((_SoundSource*)self)->getMinDistance();
}
void sfml_soundsource_getattenuation(void* self, float* result) {
    *(float*)result = ((_SoundSource*)self)->getAttenuation();
}
void sfml_soundsource_getstatus(void* self, int* result) {
    *(SoundSource::Status*)result = ((_SoundSource*)self)->getStatus();
}
void sfml_soundsource_initialize(void* self) {
    new(self) _SoundSource();
}
void (*_sfml_soundstream_ongetdata_callback)(void*, Int16**, std::size_t*, Int8*) = 0;
void sfml_soundstream_ongetdata_callback(void (*callback)(void*, Int16**, std::size_t*, Int8*)) {
    _sfml_soundstream_ongetdata_callback = callback;
}
void (*_sfml_soundstream_onseek_callback)(void*, void*) = 0;
void sfml_soundstream_onseek_callback(void (*callback)(void*, void*)) {
    _sfml_soundstream_onseek_callback = callback;
}
void (*_sfml_soundstream_onloop_callback)(void*, Int64*) = 0;
void sfml_soundstream_onloop_callback(void (*callback)(void*, Int64*)) {
    _sfml_soundstream_onloop_callback = callback;
}
class _SoundStream : public sf::SoundStream {
public:
    void* parent;
    using SoundStream::initialize;
    virtual bool onGetData(SoundStream::Chunk& data) {
        bool result;
        _sfml_soundstream_ongetdata_callback(parent, (Int16**)&data.samples, &data.sampleCount, (Int8*)&result);
        return result;
    }
    virtual void onSeek(Time timeOffset) {
        _sfml_soundstream_onseek_callback(parent, &timeOffset);
    }
    virtual Int64 onLoop() {
        Int64 result;
        _sfml_soundstream_onloop_callback(parent, (Int64*)&result);
        return result;
    }
};
void sfml_soundstream_parent(void* self, void* parent) {
    ((_SoundStream*)self)->parent = parent;
}
void sfml_soundstream_allocate(void** result) {
    *result = malloc(sizeof(_SoundStream));
}
void sfml_soundstream_free(void* self) {
    free(self);
}
void sfml_soundstream_finalize(void* self) {
    ((_SoundStream*)self)->~_SoundStream();
}
void sfml_soundstream_play(void* self) {
    ((_SoundStream*)self)->play();
}
void sfml_soundstream_pause(void* self) {
    ((_SoundStream*)self)->pause();
}
void sfml_soundstream_stop(void* self) {
    ((_SoundStream*)self)->stop();
}
void sfml_soundstream_getchannelcount(void* self, unsigned int* result) {
    *(unsigned int*)result = ((_SoundStream*)self)->getChannelCount();
}
void sfml_soundstream_getsamplerate(void* self, unsigned int* result) {
    *(unsigned int*)result = ((_SoundStream*)self)->getSampleRate();
}
void sfml_soundstream_getstatus(void* self, int* result) {
    *(SoundSource::Status*)result = ((_SoundStream*)self)->getStatus();
}
void sfml_soundstream_setplayingoffset_f4T(void* self, void* time_offset) {
    ((_SoundStream*)self)->setPlayingOffset(*(Time*)time_offset);
}
void sfml_soundstream_getplayingoffset(void* self, void* result) {
    *(Time*)result = ((_SoundStream*)self)->getPlayingOffset();
}
void sfml_soundstream_setloop_GZq(void* self, Int8 loop) {
    ((_SoundStream*)self)->setLoop(loop != 0);
}
void sfml_soundstream_getloop(void* self, Int8* result) {
    *(bool*)result = ((_SoundStream*)self)->getLoop();
}
void sfml_soundstream_initialize(void* self) {
    new(self) _SoundStream();
}
void sfml_soundstream_initialize_emSemS(void* self, unsigned int channel_count, unsigned int sample_rate) {
    ((_SoundStream*)self)->initialize(channel_count, sample_rate);
}
void sfml_soundstream_onloop(void* self, Int64* result) {
    *(Int64*)result = ((_SoundStream*)self)->onLoop();
}
void sfml_soundstream_setpitch_Bw9(void* self, float pitch) {
    ((_SoundStream*)self)->setPitch(pitch);
}
void sfml_soundstream_setvolume_Bw9(void* self, float volume) {
    ((_SoundStream*)self)->setVolume(volume);
}
void sfml_soundstream_setposition_Bw9Bw9Bw9(void* self, float x, float y, float z) {
    ((_SoundStream*)self)->setPosition(x, y, z);
}
void sfml_soundstream_setposition_NzM(void* self, void* position) {
    ((_SoundStream*)self)->setPosition(*(Vector3f*)position);
}
void sfml_soundstream_setrelativetolistener_GZq(void* self, Int8 relative) {
    ((_SoundStream*)self)->setRelativeToListener(relative != 0);
}
void sfml_soundstream_setmindistance_Bw9(void* self, float distance) {
    ((_SoundStream*)self)->setMinDistance(distance);
}
void sfml_soundstream_setattenuation_Bw9(void* self, float attenuation) {
    ((_SoundStream*)self)->setAttenuation(attenuation);
}
void sfml_soundstream_getpitch(void* self, float* result) {
    *(float*)result = ((_SoundStream*)self)->getPitch();
}
void sfml_soundstream_getvolume(void* self, float* result) {
    *(float*)result = ((_SoundStream*)self)->getVolume();
}
void sfml_soundstream_getposition(void* self, void* result) {
    *(Vector3f*)result = ((_SoundStream*)self)->getPosition();
}
void sfml_soundstream_isrelativetolistener(void* self, Int8* result) {
    *(bool*)result = ((_SoundStream*)self)->isRelativeToListener();
}
void sfml_soundstream_getmindistance(void* self, float* result) {
    *(float*)result = ((_SoundStream*)self)->getMinDistance();
}
void sfml_soundstream_getattenuation(void* self, float* result) {
    *(float*)result = ((_SoundStream*)self)->getAttenuation();
}
void sfml_music_allocate(void** result) {
    *result = malloc(sizeof(Music));
}
void sfml_music_free(void* self) {
    free(self);
}
void sfml_music_initialize(void* self) {
    new(self) Music();
}
void sfml_music_finalize(void* self) {
    ((Music*)self)->~Music();
}
void sfml_music_openfromfile_zkC(void* self, std::size_t filename_size, char* filename, Int8* result) {
    *(bool*)result = ((Music*)self)->openFromFile(std::string(filename, filename_size));
}
void sfml_music_openfrommemory_5h8vgv(void* self, void* data, std::size_t size_in_bytes, Int8* result) {
    *(bool*)result = ((Music*)self)->openFromMemory(data, size_in_bytes);
}
void sfml_music_openfromstream_PO0(void* self, void* stream, Int8* result) {
    *(bool*)result = ((Music*)self)->openFromStream(*(InputStream*)stream);
}
void sfml_music_getduration(void* self, void* result) {
    *(Time*)result = ((Music*)self)->getDuration();
}
void sfml_music_getlooppoints(void* self, void* result) {
    *(Music::TimeSpan*)result = ((Music*)self)->getLoopPoints();
}
void sfml_music_setlooppoints_TU3(void* self, void* time_points) {
    ((Music*)self)->setLoopPoints(*(Music::TimeSpan*)time_points);
}
void sfml_music_play(void* self) {
    ((Music*)self)->play();
}
void sfml_music_pause(void* self) {
    ((Music*)self)->pause();
}
void sfml_music_stop(void* self) {
    ((Music*)self)->stop();
}
void sfml_music_getchannelcount(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Music*)self)->getChannelCount();
}
void sfml_music_getsamplerate(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Music*)self)->getSampleRate();
}
void sfml_music_getstatus(void* self, int* result) {
    *(SoundSource::Status*)result = ((Music*)self)->getStatus();
}
void sfml_music_setplayingoffset_f4T(void* self, void* time_offset) {
    ((Music*)self)->setPlayingOffset(*(Time*)time_offset);
}
void sfml_music_getplayingoffset(void* self, void* result) {
    *(Time*)result = ((Music*)self)->getPlayingOffset();
}
void sfml_music_setloop_GZq(void* self, Int8 loop) {
    ((Music*)self)->setLoop(loop != 0);
}
void sfml_music_getloop(void* self, Int8* result) {
    *(bool*)result = ((Music*)self)->getLoop();
}
void sfml_music_setpitch_Bw9(void* self, float pitch) {
    ((Music*)self)->setPitch(pitch);
}
void sfml_music_setvolume_Bw9(void* self, float volume) {
    ((Music*)self)->setVolume(volume);
}
void sfml_music_setposition_Bw9Bw9Bw9(void* self, float x, float y, float z) {
    ((Music*)self)->setPosition(x, y, z);
}
void sfml_music_setposition_NzM(void* self, void* position) {
    ((Music*)self)->setPosition(*(Vector3f*)position);
}
void sfml_music_setrelativetolistener_GZq(void* self, Int8 relative) {
    ((Music*)self)->setRelativeToListener(relative != 0);
}
void sfml_music_setmindistance_Bw9(void* self, float distance) {
    ((Music*)self)->setMinDistance(distance);
}
void sfml_music_setattenuation_Bw9(void* self, float attenuation) {
    ((Music*)self)->setAttenuation(attenuation);
}
void sfml_music_getpitch(void* self, float* result) {
    *(float*)result = ((Music*)self)->getPitch();
}
void sfml_music_getvolume(void* self, float* result) {
    *(float*)result = ((Music*)self)->getVolume();
}
void sfml_music_getposition(void* self, void* result) {
    *(Vector3f*)result = ((Music*)self)->getPosition();
}
void sfml_music_isrelativetolistener(void* self, Int8* result) {
    *(bool*)result = ((Music*)self)->isRelativeToListener();
}
void sfml_music_getmindistance(void* self, float* result) {
    *(float*)result = ((Music*)self)->getMinDistance();
}
void sfml_music_getattenuation(void* self, float* result) {
    *(float*)result = ((Music*)self)->getAttenuation();
}
void sfml_sound_allocate(void** result) {
    *result = malloc(sizeof(Sound));
}
void sfml_sound_free(void* self) {
    free(self);
}
void sfml_sound_initialize(void* self) {
    new(self) Sound();
}
void sfml_sound_initialize_mWu(void* self, void* buffer) {
    new(self) Sound(*(SoundBuffer*)buffer);
}
void sfml_sound_finalize(void* self) {
    ((Sound*)self)->~Sound();
}
void sfml_sound_play(void* self) {
    ((Sound*)self)->play();
}
void sfml_sound_pause(void* self) {
    ((Sound*)self)->pause();
}
void sfml_sound_stop(void* self) {
    ((Sound*)self)->stop();
}
void sfml_sound_setbuffer_mWu(void* self, void* buffer) {
    ((Sound*)self)->setBuffer(*(SoundBuffer*)buffer);
}
void sfml_sound_setloop_GZq(void* self, Int8 loop) {
    ((Sound*)self)->setLoop(loop != 0);
}
void sfml_sound_setplayingoffset_f4T(void* self, void* time_offset) {
    ((Sound*)self)->setPlayingOffset(*(Time*)time_offset);
}
void sfml_sound_getbuffer(void* self, void** result) {
    *(SoundBuffer**)result = const_cast<SoundBuffer*>(((Sound*)self)->getBuffer());
}
void sfml_sound_getloop(void* self, Int8* result) {
    *(bool*)result = ((Sound*)self)->getLoop();
}
void sfml_sound_getplayingoffset(void* self, void* result) {
    *(Time*)result = ((Sound*)self)->getPlayingOffset();
}
void sfml_sound_getstatus(void* self, int* result) {
    *(SoundSource::Status*)result = ((Sound*)self)->getStatus();
}
void sfml_sound_resetbuffer(void* self) {
    ((Sound*)self)->resetBuffer();
}
void sfml_sound_setpitch_Bw9(void* self, float pitch) {
    ((Sound*)self)->setPitch(pitch);
}
void sfml_sound_setvolume_Bw9(void* self, float volume) {
    ((Sound*)self)->setVolume(volume);
}
void sfml_sound_setposition_Bw9Bw9Bw9(void* self, float x, float y, float z) {
    ((Sound*)self)->setPosition(x, y, z);
}
void sfml_sound_setposition_NzM(void* self, void* position) {
    ((Sound*)self)->setPosition(*(Vector3f*)position);
}
void sfml_sound_setrelativetolistener_GZq(void* self, Int8 relative) {
    ((Sound*)self)->setRelativeToListener(relative != 0);
}
void sfml_sound_setmindistance_Bw9(void* self, float distance) {
    ((Sound*)self)->setMinDistance(distance);
}
void sfml_sound_setattenuation_Bw9(void* self, float attenuation) {
    ((Sound*)self)->setAttenuation(attenuation);
}
void sfml_sound_getpitch(void* self, float* result) {
    *(float*)result = ((Sound*)self)->getPitch();
}
void sfml_sound_getvolume(void* self, float* result) {
    *(float*)result = ((Sound*)self)->getVolume();
}
void sfml_sound_getposition(void* self, void* result) {
    *(Vector3f*)result = ((Sound*)self)->getPosition();
}
void sfml_sound_isrelativetolistener(void* self, Int8* result) {
    *(bool*)result = ((Sound*)self)->isRelativeToListener();
}
void sfml_sound_getmindistance(void* self, float* result) {
    *(float*)result = ((Sound*)self)->getMinDistance();
}
void sfml_sound_getattenuation(void* self, float* result) {
    *(float*)result = ((Sound*)self)->getAttenuation();
}
void sfml_soundbuffer_allocate(void** result) {
    *result = malloc(sizeof(SoundBuffer));
}
void sfml_soundbuffer_free(void* self) {
    free(self);
}
void sfml_soundbuffer_initialize(void* self) {
    new(self) SoundBuffer();
}
void sfml_soundbuffer_finalize(void* self) {
    ((SoundBuffer*)self)->~SoundBuffer();
}
void sfml_soundbuffer_loadfromfile_zkC(void* self, std::size_t filename_size, char* filename, Int8* result) {
    *(bool*)result = ((SoundBuffer*)self)->loadFromFile(std::string(filename, filename_size));
}
void sfml_soundbuffer_loadfrommemory_5h8vgv(void* self, void* data, std::size_t size_in_bytes, Int8* result) {
    *(bool*)result = ((SoundBuffer*)self)->loadFromMemory(data, size_in_bytes);
}
void sfml_soundbuffer_loadfromstream_PO0(void* self, void* stream, Int8* result) {
    *(bool*)result = ((SoundBuffer*)self)->loadFromStream(*(InputStream*)stream);
}
void sfml_soundbuffer_loadfromsamples_xzLJvtemSemS(void* self, Int16* samples, Uint64 sample_count, unsigned int channel_count, unsigned int sample_rate, Int8* result) {
    *(bool*)result = ((SoundBuffer*)self)->loadFromSamples(samples, sample_count, channel_count, sample_rate);
}
void sfml_soundbuffer_savetofile_zkC(void* self, std::size_t filename_size, char* filename, Int8* result) {
    *(bool*)result = ((SoundBuffer*)self)->saveToFile(std::string(filename, filename_size));
}
void sfml_soundbuffer_getsamples(void* self, Int16** result) {
    *(Int16**)result = const_cast<Int16*>(((SoundBuffer*)self)->getSamples());
}
void sfml_soundbuffer_getsamplecount(void* self, Uint64* result) {
    *(Uint64*)result = ((SoundBuffer*)self)->getSampleCount();
}
void sfml_soundbuffer_getsamplerate(void* self, unsigned int* result) {
    *(unsigned int*)result = ((SoundBuffer*)self)->getSampleRate();
}
void sfml_soundbuffer_getchannelcount(void* self, unsigned int* result) {
    *(unsigned int*)result = ((SoundBuffer*)self)->getChannelCount();
}
void sfml_soundbuffer_getduration(void* self, void* result) {
    *(Time*)result = ((SoundBuffer*)self)->getDuration();
}
void (*_sfml_soundrecorder_onstart_callback)(void*, Int8*) = 0;
void sfml_soundrecorder_onstart_callback(void (*callback)(void*, Int8*)) {
    _sfml_soundrecorder_onstart_callback = callback;
}
void (*_sfml_soundrecorder_onprocesssamples_callback)(void*, Int16*, std::size_t, Int8*) = 0;
void sfml_soundrecorder_onprocesssamples_callback(void (*callback)(void*, Int16*, std::size_t, Int8*)) {
    _sfml_soundrecorder_onprocesssamples_callback = callback;
}
void (*_sfml_soundrecorder_onstop_callback)(void*) = 0;
void sfml_soundrecorder_onstop_callback(void (*callback)(void*)) {
    _sfml_soundrecorder_onstop_callback = callback;
}
class _SoundRecorder : public sf::SoundRecorder {
public:
    void* parent;
    using SoundRecorder::setProcessingInterval;
    virtual bool onStart() {
        bool result;
        _sfml_soundrecorder_onstart_callback(parent, (Int8*)&result);
        return result;
    }
    virtual bool onProcessSamples(Int16 const* samples, std::size_t sampleCount) {
        bool result;
        _sfml_soundrecorder_onprocesssamples_callback(parent, (Int16*)samples, (std::size_t)sampleCount, (Int8*)&result);
        return result;
    }
    virtual void onStop() {
        _sfml_soundrecorder_onstop_callback(parent);
    }
};
void sfml_soundrecorder_parent(void* self, void* parent) {
    ((_SoundRecorder*)self)->parent = parent;
}
void sfml_soundrecorder_allocate(void** result) {
    *result = malloc(sizeof(_SoundRecorder));
}
void sfml_soundrecorder_free(void* self) {
    free(self);
}
void sfml_soundrecorder_finalize(void* self) {
    ((_SoundRecorder*)self)->~_SoundRecorder();
}
void sfml_soundrecorder_start_emS(void* self, unsigned int sample_rate, Int8* result) {
    *(bool*)result = ((_SoundRecorder*)self)->start(sample_rate);
}
void sfml_soundrecorder_stop(void* self) {
    ((_SoundRecorder*)self)->stop();
}
void sfml_soundrecorder_getsamplerate(void* self, unsigned int* result) {
    *(unsigned int*)result = ((_SoundRecorder*)self)->getSampleRate();
}
void sfml_soundrecorder_getavailabledevices(char*** result, std::size_t* result_size) {
    static std::vector<std::string> strs;
    static std::vector<char*> bufs;
    strs = _SoundRecorder::getAvailableDevices();
    bufs.resize(strs.size());
    for (std::size_t i = 0; i < strs.size(); ++i) bufs[i] = const_cast<char*>(strs[i].c_str());
    *result_size = bufs.size();
    *result = &bufs[0];
}
void sfml_soundrecorder_getdefaultdevice(char** result) {
    static std::string str;
    str = _SoundRecorder::getDefaultDevice();
    *result = const_cast<char*>(str.c_str());
}
void sfml_soundrecorder_setdevice_zkC(void* self, std::size_t name_size, char* name, Int8* result) {
    *(bool*)result = ((_SoundRecorder*)self)->setDevice(std::string(name, name_size));
}
void sfml_soundrecorder_getdevice(void* self, char** result) {
    static std::string str;
    str = ((_SoundRecorder*)self)->getDevice();
    *result = const_cast<char*>(str.c_str());
}
void sfml_soundrecorder_setchannelcount_emS(void* self, unsigned int channel_count) {
    ((_SoundRecorder*)self)->setChannelCount(channel_count);
}
void sfml_soundrecorder_getchannelcount(void* self, unsigned int* result) {
    *(unsigned int*)result = ((_SoundRecorder*)self)->getChannelCount();
}
void sfml_soundrecorder_isavailable(Int8* result) {
    *(bool*)result = _SoundRecorder::isAvailable();
}
void sfml_soundrecorder_initialize(void* self) {
    new(self) _SoundRecorder();
}
void sfml_soundrecorder_setprocessinginterval_f4T(void* self, void* interval) {
    ((_SoundRecorder*)self)->setProcessingInterval(*(Time*)interval);
}
void sfml_soundrecorder_onstart(void* self, Int8* result) {
    *(bool*)result = ((_SoundRecorder*)self)->onStart();
}
void sfml_soundrecorder_onstop(void* self) {
    ((_SoundRecorder*)self)->onStop();
}
void sfml_soundbufferrecorder_allocate(void** result) {
    *result = malloc(sizeof(SoundBufferRecorder));
}
void sfml_soundbufferrecorder_initialize(void* self) {
    new(self) SoundBufferRecorder();
}
void sfml_soundbufferrecorder_free(void* self) {
    free(self);
}
void sfml_soundbufferrecorder_finalize(void* self) {
    ((SoundBufferRecorder*)self)->~SoundBufferRecorder();
}
void sfml_soundbufferrecorder_getbuffer(void* self, void** result) {
    *(SoundBuffer**)result = const_cast<SoundBuffer*>(&((SoundBufferRecorder*)self)->getBuffer());
}
void sfml_soundbufferrecorder_start_emS(void* self, unsigned int sample_rate, Int8* result) {
    *(bool*)result = ((SoundBufferRecorder*)self)->start(sample_rate);
}
void sfml_soundbufferrecorder_stop(void* self) {
    ((SoundBufferRecorder*)self)->stop();
}
void sfml_soundbufferrecorder_getsamplerate(void* self, unsigned int* result) {
    *(unsigned int*)result = ((SoundBufferRecorder*)self)->getSampleRate();
}
void sfml_soundbufferrecorder_getavailabledevices(char*** result, std::size_t* result_size) {
    static std::vector<std::string> strs;
    static std::vector<char*> bufs;
    strs = SoundBufferRecorder::getAvailableDevices();
    bufs.resize(strs.size());
    for (std::size_t i = 0; i < strs.size(); ++i) bufs[i] = const_cast<char*>(strs[i].c_str());
    *result_size = bufs.size();
    *result = &bufs[0];
}
void sfml_soundbufferrecorder_getdefaultdevice(char** result) {
    static std::string str;
    str = SoundBufferRecorder::getDefaultDevice();
    *result = const_cast<char*>(str.c_str());
}
void sfml_soundbufferrecorder_setdevice_zkC(void* self, std::size_t name_size, char* name, Int8* result) {
    *(bool*)result = ((SoundBufferRecorder*)self)->setDevice(std::string(name, name_size));
}
void sfml_soundbufferrecorder_getdevice(void* self, char** result) {
    static std::string str;
    str = ((SoundBufferRecorder*)self)->getDevice();
    *result = const_cast<char*>(str.c_str());
}
void sfml_soundbufferrecorder_setchannelcount_emS(void* self, unsigned int channel_count) {
    ((SoundBufferRecorder*)self)->setChannelCount(channel_count);
}
void sfml_soundbufferrecorder_getchannelcount(void* self, unsigned int* result) {
    *(unsigned int*)result = ((SoundBufferRecorder*)self)->getChannelCount();
}
void sfml_soundbufferrecorder_isavailable(Int8* result) {
    *(bool*)result = SoundBufferRecorder::isAvailable();
}
void sfml_audio_version(int* major, int* minor, int* patch) {
    *major = SFML_VERSION_MAJOR;
    *minor = SFML_VERSION_MINOR;
    *patch = SFML_VERSION_PATCH;
}
}
