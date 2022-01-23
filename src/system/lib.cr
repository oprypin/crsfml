require "../common"
{% unless flag?(:win32) %}
@[Link("stdc++")]
{% end %}
@[Link("sfml-system")]
{% if flag?(:win32) %}
@[Link(ldflags: "\"#{__DIR__}\\ext.obj\"")]
{% else %}
@[Link(ldflags: "'#{__DIR__}/ext.o'")]
{% end %}
lib SFMLExt
  fun sfml_time_allocate(result : Void**)
  fun sfml_time_free(self : Void*)
  fun sfml_time_initialize(self : Void*)
  fun sfml_time_asseconds(self : Void*, result : LibC::Float*)
  fun sfml_time_asmilliseconds(self : Void*, result : Int32*)
  fun sfml_time_asmicroseconds(self : Void*, result : Int64*)
  fun sfml_operator_eq_f4Tf4T(left : Void*, right : Void*, result : Bool*)
  fun sfml_operator_ne_f4Tf4T(left : Void*, right : Void*, result : Bool*)
  fun sfml_operator_lt_f4Tf4T(left : Void*, right : Void*, result : Bool*)
  fun sfml_operator_gt_f4Tf4T(left : Void*, right : Void*, result : Bool*)
  fun sfml_operator_le_f4Tf4T(left : Void*, right : Void*, result : Bool*)
  fun sfml_operator_ge_f4Tf4T(left : Void*, right : Void*, result : Bool*)
  fun sfml_operator_sub_f4T(right : Void*, result : Void*)
  fun sfml_operator_add_f4Tf4T(left : Void*, right : Void*, result : Void*)
  fun sfml_operator_sub_f4Tf4T(left : Void*, right : Void*, result : Void*)
  fun sfml_operator_mul_f4TBw9(left : Void*, right : LibC::Float, result : Void*)
  fun sfml_operator_mul_f4TG4x(left : Void*, right : Int64, result : Void*)
  fun sfml_operator_div_f4TBw9(left : Void*, right : LibC::Float, result : Void*)
  fun sfml_operator_div_f4TG4x(left : Void*, right : Int64, result : Void*)
  fun sfml_operator_div_f4Tf4T(left : Void*, right : Void*, result : LibC::Float*)
  fun sfml_operator_mod_f4Tf4T(left : Void*, right : Void*, result : Void*)
  fun sfml_time_initialize_PxG(self : Void*, copy : Void*)
  fun sfml_seconds_Bw9(amount : LibC::Float, result : Void*)
  fun sfml_milliseconds_qe2(amount : Int32, result : Void*)
  fun sfml_microseconds_G4x(amount : Int64, result : Void*)
  fun sfml_clock_allocate(result : Void**)
  fun sfml_clock_finalize(self : Void*)
  fun sfml_clock_free(self : Void*)
  fun sfml_clock_initialize(self : Void*)
  fun sfml_clock_getelapsedtime(self : Void*, result : Void*)
  fun sfml_clock_restart(self : Void*, result : Void*)
  fun sfml_clock_initialize_LuC(self : Void*, copy : Void*)
  fun sfml_inputstream_read_callback(callback : (Void*, Void*, Int64, Int64* ->))
  fun sfml_inputstream_seek_callback(callback : (Void*, Int64, Int64* ->))
  fun sfml_inputstream_tell_callback(callback : (Void*, Int64* ->))
  fun sfml_inputstream_getsize_callback(callback : (Void*, Int64* ->))
  fun sfml_inputstream_parent(self : Void*, parent : Void*)
  fun sfml_inputstream_allocate(result : Void**)
  fun sfml_inputstream_initialize(self : Void*)
  fun sfml_inputstream_finalize(self : Void*)
  fun sfml_inputstream_free(self : Void*)
  fun sfml_noncopyable_allocate(result : Void**)
  fun sfml_noncopyable_free(self : Void*)
  fun sfml_fileinputstream_allocate(result : Void**)
  fun sfml_fileinputstream_free(self : Void*)
  fun sfml_fileinputstream_initialize(self : Void*)
  fun sfml_fileinputstream_finalize(self : Void*)
  fun sfml_fileinputstream_open_zkC(self : Void*, filename_size : LibC::SizeT, filename : LibC::Char*, result : Bool*)
  fun sfml_fileinputstream_read_xALG4x(self : Void*, data : UInt8*, size : Int64, result : Int64*)
  fun sfml_fileinputstream_seek_G4x(self : Void*, position : Int64, result : Int64*)
  fun sfml_fileinputstream_tell(self : Void*, result : Int64*)
  fun sfml_fileinputstream_getsize(self : Void*, result : Int64*)
  fun sfml_memoryinputstream_allocate(result : Void**)
  fun sfml_memoryinputstream_finalize(self : Void*)
  fun sfml_memoryinputstream_free(self : Void*)
  fun sfml_memoryinputstream_initialize(self : Void*)
  fun sfml_memoryinputstream_open_5h8vgv(self : Void*, data : UInt8*, size_in_bytes : LibC::SizeT)
  fun sfml_memoryinputstream_read_xALG4x(self : Void*, data : UInt8*, size : Int64, result : Int64*)
  fun sfml_memoryinputstream_seek_G4x(self : Void*, position : Int64, result : Int64*)
  fun sfml_memoryinputstream_tell(self : Void*, result : Int64*)
  fun sfml_memoryinputstream_getsize(self : Void*, result : Int64*)
  fun sfml_memoryinputstream_initialize_kYd(self : Void*, copy : Void*)
  fun sfml_mutex_allocate(result : Void**)
  fun sfml_mutex_free(self : Void*)
  fun sfml_mutex_initialize(self : Void*)
  fun sfml_mutex_finalize(self : Void*)
  fun sfml_mutex_lock(self : Void*)
  fun sfml_mutex_unlock(self : Void*)
  fun sfml_sleep_f4T(duration : Void*)
  fun sfml_thread_allocate(result : Void**)
  fun sfml_thread_free(self : Void*)
  fun sfml_thread_initialize_XPcbdx(self : Void*, function : (Void*)->, argument : Void*)
  fun sfml_thread_finalize(self : Void*)
  fun sfml_thread_launch(self : Void*)
  fun sfml_thread_wait(self : Void*)
  fun sfml_thread_terminate(self : Void*)
  fun sfml_system_version(LibC::Int*, LibC::Int*, LibC::Int*)
end
