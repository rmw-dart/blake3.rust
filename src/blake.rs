use core::slice;
use safer_ffi::prelude::*;

#[derive_ReprC]
#[ReprC::opaque]
pub struct Hasher {
  pub h: blake3::Hasher,
}

#[ffi_export]
pub fn hash_free(data: *mut u8) {
  unsafe {
    let p = std::slice::from_raw_parts_mut(data, 32).as_mut_ptr();
    Box::from_raw(p);
  }
}

#[ffi_export]
pub fn hash(data: *const u8, len: usize) -> *const u8 {
  let v = unsafe { slice::from_raw_parts(data, len) };
  let h = Box::new(*blake3::hash(&v).as_bytes());
  Box::into_raw(h) as *const u8
}

impl Hasher {
  pub fn new() -> Self {
    Self {
      h: ::blake3::Hasher::new(),
    }
  }
}

#[ffi_export]
pub fn hasher_new() -> repr_c::Box<Hasher> {
  repr_c::Box::new(Hasher::new())
}

#[ffi_export]
pub fn hasher_update(hasher: &mut Hasher, data: *const u8, len: usize) {
  let v = unsafe { slice::from_raw_parts(data, len) };
  hasher.h.update(v);
}

#[ffi_export]
pub fn hasher_end(hasher: repr_c::Box<Hasher>) -> *const u8 {
  let h = Box::new(*hasher.h.finalize().as_bytes());
  drop(hasher);
  Box::into_raw(h) as *const u8
}

#[::safer_ffi::cfg_headers]
#[test]
fn c_headers() -> ::std::io::Result<()> {
  safer_ffi::headers::builder()
    .to_file("h/blake3.h")?
    .generate()
}
