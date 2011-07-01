#ifdef HAVE_RB_THREAD_BLOCKING_REGION
#  ifndef HAVE_RB_THREAD_IO_BLOCKING_REGION
#    define rb_thread_io_blocking_region(fn,data,fd) \
            rb_thread_blocking_region((fn),(data),RUBY_UBF_IO,0)
#  endif
#endif
