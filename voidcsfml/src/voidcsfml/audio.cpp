#include <voidcsfml/audio.h>
#include <SFML/Audio.hpp>
using namespace sf;
void listener_setglobalvolume_Bw9(float volume) {
    Listener::setGlobalVolume((float)volume);
}
void listener_getglobalvolume(float* result) {
    *(float*)result = Listener::getGlobalVolume();
}
void listener_setposition_Bw9Bw9Bw9(float x, float y, float z) {
    Listener::setPosition((float)x, (float)y, (float)z);
}
void listener_setposition_NzM(void* position) {
    Listener::setPosition(*(Vector3f*)position);
}
void listener_getposition(void* result) {
    *(Vector3f*)result = Listener::getPosition();
}
void listener_setdirection_Bw9Bw9Bw9(float x, float y, float z) {
    Listener::setDirection((float)x, (float)y, (float)z);
}
void listener_setdirection_NzM(void* direction) {
    Listener::setDirection(*(Vector3f*)direction);
}
void listener_getdirection(void* result) {
    *(Vector3f*)result = Listener::getDirection();
}
void listener_setupvector_Bw9Bw9Bw9(float x, float y, float z) {
    Listener::setUpVector((float)x, (float)y, (float)z);
}
void listener_setupvector_NzM(void* up_vector) {
    Listener::setUpVector(*(Vector3f*)up_vector);
}
void listener_getupvector(void* result) {
    *(Vector3f*)result = Listener::getUpVector();
}
void soundsource_finalize(void* self) {
    ((SoundSource*)self)->~SoundSource();
}
void soundsource_setpitch_Bw9(void* self, float pitch) {
    ((SoundSource*)self)->setPitch((float)pitch);
}
void soundsource_setvolume_Bw9(void* self, float volume) {
    ((SoundSource*)self)->setVolume((float)volume);
}
void soundsource_setposition_Bw9Bw9Bw9(void* self, float x, float y, float z) {
    ((SoundSource*)self)->setPosition((float)x, (float)y, (float)z);
}
void soundsource_setposition_NzM(void* self, void* position) {
    ((SoundSource*)self)->setPosition(*(Vector3f*)position);
}
void soundsource_setrelativetolistener_GZq(void* self, unsigned char relative) {
    ((SoundSource*)self)->setRelativeToListener((bool)relative);
}
void soundsource_setmindistance_Bw9(void* self, float distance) {
    ((SoundSource*)self)->setMinDistance((float)distance);
}
void soundsource_setattenuation_Bw9(void* self, float attenuation) {
    ((SoundSource*)self)->setAttenuation((float)attenuation);
}
void soundsource_getpitch(void* self, float* result) {
    *(float*)result = ((SoundSource*)self)->getPitch();
}
void soundsource_getvolume(void* self, float* result) {
    *(float*)result = ((SoundSource*)self)->getVolume();
}
void soundsource_getposition(void* self, void* result) {
    *(Vector3f*)result = ((SoundSource*)self)->getPosition();
}
void soundsource_isrelativetolistener(void* self, unsigned char* result) {
    *(bool*)result = ((SoundSource*)self)->isRelativeToListener();
}
void soundsource_getmindistance(void* self, float* result) {
    *(float*)result = ((SoundSource*)self)->getMinDistance();
}
void soundsource_getattenuation(void* self, float* result) {
    *(float*)result = ((SoundSource*)self)->getAttenuation();
}
class _SoundStream : public sf::SoundStream {
public:
    using SoundStream::initialize;
    virtual bool onGetData(SoundStream::Chunk& data) {
        bool result;
        soundstream_ongetdata_callback((void*)this, (int16_t**)&data.samples, &data.sampleCount, (unsigned char*)&result);
        return result;
    }
    virtual void onSeek(Time timeOffset) {
        soundstream_onseek_callback((void*)this, &timeOffset);
    }
};
void (*soundstream_ongetdata_callback)(void*, int16_t**, size_t*, unsigned char*) = 0;
void (*soundstream_onseek_callback)(void*, void*) = 0;
void soundstream_finalize(void* self) {
    ((_SoundStream*)self)->~_SoundStream();
}
void soundstream_play(void* self) {
    ((_SoundStream*)self)->play();
}
void soundstream_pause(void* self) {
    ((_SoundStream*)self)->pause();
}
void soundstream_stop(void* self) {
    ((_SoundStream*)self)->stop();
}
void soundstream_getchannelcount(void* self, unsigned int* result) {
    *(unsigned int*)result = ((_SoundStream*)self)->getChannelCount();
}
void soundstream_getsamplerate(void* self, unsigned int* result) {
    *(unsigned int*)result = ((_SoundStream*)self)->getSampleRate();
}
void soundstream_getstatus(void* self, int* result) {
    *(SoundSource::Status*)result = ((_SoundStream*)self)->getStatus();
}
void soundstream_setplayingoffset_f4T(void* self, void* time_offset) {
    ((_SoundStream*)self)->setPlayingOffset(*(Time*)time_offset);
}
void soundstream_getplayingoffset(void* self, void* result) {
    *(Time*)result = ((_SoundStream*)self)->getPlayingOffset();
}
void soundstream_setloop_GZq(void* self, unsigned char loop) {
    ((_SoundStream*)self)->setLoop((bool)loop);
}
void soundstream_getloop(void* self, unsigned char* result) {
    *(bool*)result = ((_SoundStream*)self)->getLoop();
}
void soundstream_initialize(void* self) {
    new(self) _SoundStream();
}
void soundstream_initialize_emSemS(void* self, unsigned int channel_count, unsigned int sample_rate) {
    ((_SoundStream*)self)->initialize((unsigned int)channel_count, (unsigned int)sample_rate);
}
void soundstream_setpitch_Bw9(void* self, float pitch) {
    ((_SoundStream*)self)->setPitch((float)pitch);
}
void soundstream_setvolume_Bw9(void* self, float volume) {
    ((_SoundStream*)self)->setVolume((float)volume);
}
void soundstream_setposition_Bw9Bw9Bw9(void* self, float x, float y, float z) {
    ((_SoundStream*)self)->setPosition((float)x, (float)y, (float)z);
}
void soundstream_setposition_NzM(void* self, void* position) {
    ((_SoundStream*)self)->setPosition(*(Vector3f*)position);
}
void soundstream_setrelativetolistener_GZq(void* self, unsigned char relative) {
    ((_SoundStream*)self)->setRelativeToListener((bool)relative);
}
void soundstream_setmindistance_Bw9(void* self, float distance) {
    ((_SoundStream*)self)->setMinDistance((float)distance);
}
void soundstream_setattenuation_Bw9(void* self, float attenuation) {
    ((_SoundStream*)self)->setAttenuation((float)attenuation);
}
void soundstream_getpitch(void* self, float* result) {
    *(float*)result = ((_SoundStream*)self)->getPitch();
}
void soundstream_getvolume(void* self, float* result) {
    *(float*)result = ((_SoundStream*)self)->getVolume();
}
void soundstream_getposition(void* self, void* result) {
    *(Vector3f*)result = ((_SoundStream*)self)->getPosition();
}
void soundstream_isrelativetolistener(void* self, unsigned char* result) {
    *(bool*)result = ((_SoundStream*)self)->isRelativeToListener();
}
void soundstream_getmindistance(void* self, float* result) {
    *(float*)result = ((_SoundStream*)self)->getMinDistance();
}
void soundstream_getattenuation(void* self, float* result) {
    *(float*)result = ((_SoundStream*)self)->getAttenuation();
}
void music_initialize(void* self) {
    new(self) Music();
}
void music_finalize(void* self) {
    ((Music*)self)->~Music();
}
void music_openfromfile_zkC(void* self, size_t filename_size, char* filename, unsigned char* result) {
    *(bool*)result = ((Music*)self)->openFromFile(std::string(filename, filename_size));
}
void music_openfrommemory_5h8vgv(void* self, void* data, size_t size_in_bytes, unsigned char* result) {
    *(bool*)result = ((Music*)self)->openFromMemory(data, size_in_bytes);
}
void music_openfromstream_PO0(void* self, void* stream, unsigned char* result) {
    *(bool*)result = ((Music*)self)->openFromStream(*(InputStream*)stream);
}
void music_getduration(void* self, void* result) {
    *(Time*)result = ((Music*)self)->getDuration();
}
void music_play(void* self) {
    ((Music*)self)->play();
}
void music_pause(void* self) {
    ((Music*)self)->pause();
}
void music_stop(void* self) {
    ((Music*)self)->stop();
}
void music_getchannelcount(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Music*)self)->getChannelCount();
}
void music_getsamplerate(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Music*)self)->getSampleRate();
}
void music_getstatus(void* self, int* result) {
    *(SoundSource::Status*)result = ((Music*)self)->getStatus();
}
void music_setplayingoffset_f4T(void* self, void* time_offset) {
    ((Music*)self)->setPlayingOffset(*(Time*)time_offset);
}
void music_getplayingoffset(void* self, void* result) {
    *(Time*)result = ((Music*)self)->getPlayingOffset();
}
void music_setloop_GZq(void* self, unsigned char loop) {
    ((Music*)self)->setLoop((bool)loop);
}
void music_getloop(void* self, unsigned char* result) {
    *(bool*)result = ((Music*)self)->getLoop();
}
void music_setpitch_Bw9(void* self, float pitch) {
    ((Music*)self)->setPitch((float)pitch);
}
void music_setvolume_Bw9(void* self, float volume) {
    ((Music*)self)->setVolume((float)volume);
}
void music_setposition_Bw9Bw9Bw9(void* self, float x, float y, float z) {
    ((Music*)self)->setPosition((float)x, (float)y, (float)z);
}
void music_setposition_NzM(void* self, void* position) {
    ((Music*)self)->setPosition(*(Vector3f*)position);
}
void music_setrelativetolistener_GZq(void* self, unsigned char relative) {
    ((Music*)self)->setRelativeToListener((bool)relative);
}
void music_setmindistance_Bw9(void* self, float distance) {
    ((Music*)self)->setMinDistance((float)distance);
}
void music_setattenuation_Bw9(void* self, float attenuation) {
    ((Music*)self)->setAttenuation((float)attenuation);
}
void music_getpitch(void* self, float* result) {
    *(float*)result = ((Music*)self)->getPitch();
}
void music_getvolume(void* self, float* result) {
    *(float*)result = ((Music*)self)->getVolume();
}
void music_getposition(void* self, void* result) {
    *(Vector3f*)result = ((Music*)self)->getPosition();
}
void music_isrelativetolistener(void* self, unsigned char* result) {
    *(bool*)result = ((Music*)self)->isRelativeToListener();
}
void music_getmindistance(void* self, float* result) {
    *(float*)result = ((Music*)self)->getMinDistance();
}
void music_getattenuation(void* self, float* result) {
    *(float*)result = ((Music*)self)->getAttenuation();
}
void sound_initialize(void* self) {
    new(self) Sound();
}
void sound_initialize_mWu(void* self, void* buffer) {
    new(self) Sound(*(SoundBuffer*)buffer);
}
void sound_finalize(void* self) {
    ((Sound*)self)->~Sound();
}
void sound_play(void* self) {
    ((Sound*)self)->play();
}
void sound_pause(void* self) {
    ((Sound*)self)->pause();
}
void sound_stop(void* self) {
    ((Sound*)self)->stop();
}
void sound_setbuffer_mWu(void* self, void* buffer) {
    ((Sound*)self)->setBuffer(*(SoundBuffer*)buffer);
}
void sound_setloop_GZq(void* self, unsigned char loop) {
    ((Sound*)self)->setLoop((bool)loop);
}
void sound_setplayingoffset_f4T(void* self, void* time_offset) {
    ((Sound*)self)->setPlayingOffset(*(Time*)time_offset);
}
void sound_getbuffer(void* self, void** result) {
    *(SoundBuffer**)result = const_cast<SoundBuffer*>(((Sound*)self)->getBuffer());
}
void sound_getloop(void* self, unsigned char* result) {
    *(bool*)result = ((Sound*)self)->getLoop();
}
void sound_getplayingoffset(void* self, void* result) {
    *(Time*)result = ((Sound*)self)->getPlayingOffset();
}
void sound_getstatus(void* self, int* result) {
    *(SoundSource::Status*)result = ((Sound*)self)->getStatus();
}
void sound_resetbuffer(void* self) {
    ((Sound*)self)->resetBuffer();
}
void sound_setpitch_Bw9(void* self, float pitch) {
    ((Sound*)self)->setPitch((float)pitch);
}
void sound_setvolume_Bw9(void* self, float volume) {
    ((Sound*)self)->setVolume((float)volume);
}
void sound_setposition_Bw9Bw9Bw9(void* self, float x, float y, float z) {
    ((Sound*)self)->setPosition((float)x, (float)y, (float)z);
}
void sound_setposition_NzM(void* self, void* position) {
    ((Sound*)self)->setPosition(*(Vector3f*)position);
}
void sound_setrelativetolistener_GZq(void* self, unsigned char relative) {
    ((Sound*)self)->setRelativeToListener((bool)relative);
}
void sound_setmindistance_Bw9(void* self, float distance) {
    ((Sound*)self)->setMinDistance((float)distance);
}
void sound_setattenuation_Bw9(void* self, float attenuation) {
    ((Sound*)self)->setAttenuation((float)attenuation);
}
void sound_getpitch(void* self, float* result) {
    *(float*)result = ((Sound*)self)->getPitch();
}
void sound_getvolume(void* self, float* result) {
    *(float*)result = ((Sound*)self)->getVolume();
}
void sound_getposition(void* self, void* result) {
    *(Vector3f*)result = ((Sound*)self)->getPosition();
}
void sound_isrelativetolistener(void* self, unsigned char* result) {
    *(bool*)result = ((Sound*)self)->isRelativeToListener();
}
void sound_getmindistance(void* self, float* result) {
    *(float*)result = ((Sound*)self)->getMinDistance();
}
void sound_getattenuation(void* self, float* result) {
    *(float*)result = ((Sound*)self)->getAttenuation();
}
void soundbuffer_initialize(void* self) {
    new(self) SoundBuffer();
}
void soundbuffer_finalize(void* self) {
    ((SoundBuffer*)self)->~SoundBuffer();
}
void soundbuffer_loadfromfile_zkC(void* self, size_t filename_size, char* filename, unsigned char* result) {
    *(bool*)result = ((SoundBuffer*)self)->loadFromFile(std::string(filename, filename_size));
}
void soundbuffer_loadfrommemory_5h8vgv(void* self, void* data, size_t size_in_bytes, unsigned char* result) {
    *(bool*)result = ((SoundBuffer*)self)->loadFromMemory(data, size_in_bytes);
}
void soundbuffer_loadfromstream_PO0(void* self, void* stream, unsigned char* result) {
    *(bool*)result = ((SoundBuffer*)self)->loadFromStream(*(InputStream*)stream);
}
void soundbuffer_loadfromsamples_xzLJvtemSemS(void* self, int16_t* samples, uint64_t sample_count, unsigned int channel_count, unsigned int sample_rate, unsigned char* result) {
    *(bool*)result = ((SoundBuffer*)self)->loadFromSamples((Int16 const*)samples, sample_count, (unsigned int)channel_count, (unsigned int)sample_rate);
}
void soundbuffer_savetofile_zkC(void* self, size_t filename_size, char* filename, unsigned char* result) {
    *(bool*)result = ((SoundBuffer*)self)->saveToFile(std::string(filename, filename_size));
}
void soundbuffer_getsamples(void* self, int16_t** result) {
    *(Int16**)result = const_cast<Int16*>(((SoundBuffer*)self)->getSamples());
}
void soundbuffer_getsamplecount(void* self, uint64_t* result) {
    *(Uint64*)result = ((SoundBuffer*)self)->getSampleCount();
}
void soundbuffer_getsamplerate(void* self, unsigned int* result) {
    *(unsigned int*)result = ((SoundBuffer*)self)->getSampleRate();
}
void soundbuffer_getchannelcount(void* self, unsigned int* result) {
    *(unsigned int*)result = ((SoundBuffer*)self)->getChannelCount();
}
void soundbuffer_getduration(void* self, void* result) {
    *(Time*)result = ((SoundBuffer*)self)->getDuration();
}
class _SoundRecorder : public sf::SoundRecorder {
public:
    using SoundRecorder::setProcessingInterval;
    virtual bool onStart() {
        bool result;
        soundrecorder_onstart_callback((void*)this, (unsigned char*)&result);
        return result;
    }
    virtual bool onProcessSamples(Int16 const* samples, std::size_t sampleCount) {
        bool result;
        soundrecorder_onprocesssamples_callback((void*)this, (int16_t*)samples, (size_t)sampleCount, (unsigned char*)&result);
        return result;
    }
    virtual void onStop() {
        soundrecorder_onstop_callback((void*)this);
    }
};
void (*soundrecorder_onstart_callback)(void*, unsigned char*) = 0;
void (*soundrecorder_onprocesssamples_callback)(void*, int16_t*, size_t, unsigned char*) = 0;
void (*soundrecorder_onstop_callback)(void*) = 0;
void soundrecorder_finalize(void* self) {
    ((_SoundRecorder*)self)->~_SoundRecorder();
}
void soundrecorder_start_emS(void* self, unsigned int sample_rate, unsigned char* result) {
    *(bool*)result = ((_SoundRecorder*)self)->start((unsigned int)sample_rate);
}
void soundrecorder_stop(void* self) {
    ((_SoundRecorder*)self)->stop();
}
void soundrecorder_getsamplerate(void* self, unsigned int* result) {
    *(unsigned int*)result = ((_SoundRecorder*)self)->getSampleRate();
}
void soundrecorder_getavailabledevices(char*** result, size_t* result_size) {
    static std::vector<std::string> strs;
    static std::vector<char*> bufs;
    strs = _SoundRecorder::getAvailableDevices();
    bufs.resize(strs.size());
    for (std::size_t i = 0; i < strs.size(); ++i) bufs[i] = const_cast<char*>(strs[i].c_str());
    *result_size = bufs.size();
    *result = &bufs[0];
}
void soundrecorder_getdefaultdevice(char** result) {
    static std::string str;
    str = _SoundRecorder::getDefaultDevice();
    *result = const_cast<char*>(str.c_str());
}
void soundrecorder_setdevice_zkC(void* self, size_t name_size, char* name, unsigned char* result) {
    *(bool*)result = ((_SoundRecorder*)self)->setDevice(std::string(name, name_size));
}
void soundrecorder_getdevice(void* self, char** result) {
    static std::string str;
    str = ((_SoundRecorder*)self)->getDevice();
    *result = const_cast<char*>(str.c_str());
}
void soundrecorder_setchannelcount_emS(void* self, unsigned int channel_count) {
    ((_SoundRecorder*)self)->setChannelCount((unsigned int)channel_count);
}
void soundrecorder_getchannelcount(void* self, unsigned int* result) {
    *(unsigned int*)result = ((_SoundRecorder*)self)->getChannelCount();
}
void soundrecorder_isavailable(unsigned char* result) {
    *(bool*)result = _SoundRecorder::isAvailable();
}
void soundrecorder_initialize(void* self) {
    new(self) _SoundRecorder();
}
void soundrecorder_setprocessinginterval_f4T(void* self, void* interval) {
    ((_SoundRecorder*)self)->setProcessingInterval(*(Time*)interval);
}
void soundrecorder_onstart(void* self, unsigned char* result) {
    *(bool*)result = ((_SoundRecorder*)self)->onStart();
}
void soundrecorder_onstop(void* self) {
    ((_SoundRecorder*)self)->onStop();
}
void soundbufferrecorder_initialize(void* self) {
    new(self) SoundBufferRecorder();
}
void soundbufferrecorder_finalize(void* self) {
    ((SoundBufferRecorder*)self)->~SoundBufferRecorder();
}
void soundbufferrecorder_getbuffer(void* self, void** result) {
    *(SoundBuffer**)result = const_cast<SoundBuffer*>(&((SoundBufferRecorder*)self)->getBuffer());
}
void soundbufferrecorder_start_emS(void* self, unsigned int sample_rate, unsigned char* result) {
    *(bool*)result = ((SoundBufferRecorder*)self)->start((unsigned int)sample_rate);
}
void soundbufferrecorder_stop(void* self) {
    ((SoundBufferRecorder*)self)->stop();
}
void soundbufferrecorder_getsamplerate(void* self, unsigned int* result) {
    *(unsigned int*)result = ((SoundBufferRecorder*)self)->getSampleRate();
}
void soundbufferrecorder_getavailabledevices(char*** result, size_t* result_size) {
    static std::vector<std::string> strs;
    static std::vector<char*> bufs;
    strs = SoundBufferRecorder::getAvailableDevices();
    bufs.resize(strs.size());
    for (std::size_t i = 0; i < strs.size(); ++i) bufs[i] = const_cast<char*>(strs[i].c_str());
    *result_size = bufs.size();
    *result = &bufs[0];
}
void soundbufferrecorder_getdefaultdevice(char** result) {
    static std::string str;
    str = SoundBufferRecorder::getDefaultDevice();
    *result = const_cast<char*>(str.c_str());
}
void soundbufferrecorder_setdevice_zkC(void* self, size_t name_size, char* name, unsigned char* result) {
    *(bool*)result = ((SoundBufferRecorder*)self)->setDevice(std::string(name, name_size));
}
void soundbufferrecorder_getdevice(void* self, char** result) {
    static std::string str;
    str = ((SoundBufferRecorder*)self)->getDevice();
    *result = const_cast<char*>(str.c_str());
}
void soundbufferrecorder_setchannelcount_emS(void* self, unsigned int channel_count) {
    ((SoundBufferRecorder*)self)->setChannelCount((unsigned int)channel_count);
}
void soundbufferrecorder_getchannelcount(void* self, unsigned int* result) {
    *(unsigned int*)result = ((SoundBufferRecorder*)self)->getChannelCount();
}
void soundbufferrecorder_isavailable(unsigned char* result) {
    *(bool*)result = SoundBufferRecorder::isAvailable();
}
void sfml_audio_version(int* major, int* minor, int* patch) {
    *major = SFML_VERSION_MAJOR;
    *minor = SFML_VERSION_MINOR;
    *patch = SFML_VERSION_PATCH;
}
