pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with rclx.stddef_h;
with rclx.rcutils_allocator_h;
with rclx.rcutils_types_rcutils_ret_h;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package rclx.rcutils_types_string_map_h is

  -- Copyright 2017 Open Source Robotics Foundation, Inc.
  -- Licensed under the Apache License, Version 2.0 (the "License");
  -- you may not use this file except in compliance with the License.
  -- You may obtain a copy of the License at
  --     http://www.apache.org/licenses/LICENSE-2.0
  -- Unless required by applicable law or agreed to in writing, software
  -- distributed under the License is distributed on an "AS IS" BASIS,
  -- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  -- See the License for the specific language governing permissions and
  -- limitations under the License.
   --  skipped empty struct rcutils_string_map_impl_t

   type rcutils_string_map_t is record
      impl : System.Address;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:34
   end record;
   pragma Convention (C_Pass_By_Copy, rcutils_string_map_t);  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:32

  --/ Return an empty string map struct.
  -- * This function returns an empty and zero initialized string map struct.
  -- *
  -- * Example:
  -- *
  -- * ```c
  -- * // Do not do this:
  -- * // rcutils_string_map_t foo;
  -- * // rcutils_string_map_fini(&foo); // undefined behavior!
  -- *
  -- * // Do this instead:
  -- * rcutils_string_map_t bar = rcutils_get_zero_initialized_string_array();
  -- * rcutils_string_array_fini(&bar); // ok
  -- * ```
  -- *  

   function rcutils_get_zero_initialized_string_map return rcutils_string_map_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:56
   pragma Import (C, rcutils_get_zero_initialized_string_map, "rcutils_get_zero_initialized_string_map");

  --/ Initialize a rcutils_string_map_t, allocating space for given capacity.
  --*
  -- * This function initializes the rcutils_string_map_t with a given initial
  -- * capacity for entries.
  -- * Note this does not allocate space for keys or values in the map, just the
  -- * arrays of pointers to the keys and values.
  -- * rcutils_string_map_set() should still be used when assigning values.
  -- *
  -- * The string_map argument should point to allocated memory and should have
  -- * been zero initialized with rcutils_get_zero_initialized_string_map().
  -- * For example:
  -- *
  -- * ```c
  -- * rcutils_string_map_t string_map = rcutils_get_zero_initialized_string_map();
  -- * rcutils_ret_t ret =
  -- *   rcutils_string_map_init(&string_map, 10, rcutils_get_default_allocator());
  -- * if (ret != RCUTILS_RET_OK) {
  -- *   // ... do error handling
  -- * }
  -- * // ... use the string map and when done:
  -- * ret = rcutils_string_map_fini(&string_map);
  -- * if (ret != RCUTILS_RET_OK) {
  -- *   // ... do error handling
  -- * }
  -- * ```
  -- *
  -- * \param[inout] string_map rcutils_string_map_t to be initialized
  -- * \param[in] initial_capacity the amount of initial capacity for the string map
  -- * \param[in] allocator the allocator to use through out the lifetime of the map
  -- * \return `RCUTILS_RET_OK` if successful, or
  -- * \return `RCUTILS_RET_INVALID_ARGUMENT` for invalid arguments, or
  -- * \return `RCUTILS_RET_BAD_ALLOC` if memory allocation fails, or
  -- * \return `RCUTILS_RET_STRING_MAP_ALREADY_INIT` if already initialized, or
  -- * \return `RCUTILS_RET_ERROR` if an unknown error occurs
  --  

   function rcutils_string_map_init
     (string_map : access rcutils_string_map_t;
      initial_capacity : rclx.stddef_h.size_t;
      allocator : rclx.rcutils_allocator_h.rcutils_allocator_t) return rclx.rcutils_types_rcutils_ret_h.rcutils_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:96
   pragma Import (C, rcutils_string_map_init, "rcutils_string_map_init");

  --/ Finalize the previously initialized string map struct.
  --*
  -- * This function will free any resources which were created when initializing
  -- * or when calling rcutils_string_map_set().
  -- *
  -- * \param[inout] string_map rcutils_string_map_t to be finalized
  -- * \return `RCUTILS_RET_OK` if successful, or
  -- * \return `RCUTILS_RET_INVALID_ARGUMENT` for invalid arguments, or
  -- * \return `RCUTILS_RET_ERROR` if an unknown error occurs
  --  

   function rcutils_string_map_fini (string_map : access rcutils_string_map_t) return rclx.rcutils_types_rcutils_ret_h.rcutils_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:114
   pragma Import (C, rcutils_string_map_fini, "rcutils_string_map_fini");

  --/ Get the current capacity of the string map.
  --*
  -- * This function will return the internal capacity of the map, which is the
  -- * maximum number of key value pairs the map could hold.
  -- * The capacity can be set initially with rcutils_string_map_init() or
  -- * with rcutils_string_map_reserve().
  -- * The capacity does not indicate how many key value paris are stored in the
  -- * map, the rcutils_string_map_get_size() function can provide that.
  -- *
  -- * \param[in] string_map rcutils_string_map_t to be queried
  -- * \param[out] capacity capacity of the string map
  -- * \return `RCUTILS_RET_OK` if successful, or
  -- * \return `RCUTILS_RET_INVALID_ARGUMENT` for invalid arguments, or
  -- * \return `RCUTILS_RET_STRING_MAP_INVALID` if the string map is invalid, or
  -- * \return `RCUTILS_RET_ERROR` if an unknown error occurs
  --  

   function rcutils_string_map_get_capacity (string_map : access constant rcutils_string_map_t; capacity : access rclx.stddef_h.size_t) return rclx.rcutils_types_rcutils_ret_h.rcutils_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:135
   pragma Import (C, rcutils_string_map_get_capacity, "rcutils_string_map_get_capacity");

  --/ Get the current size of the string map.
  --*
  -- * This function will return the internal size of the map, which is the
  -- * current number of key value pairs in the map.
  -- * The size is changed when calling rcutils_string_map_set_no_resize(),
  -- * rcutils_string_map_set(), or rcutils_string_map_unset().
  -- *
  -- * \param[in] string_map rcutils_string_map_t to be queried
  -- * \param[out] size size of the string map
  -- * \return `RCUTILS_RET_OK` if successful, or
  -- * \return `RCUTILS_RET_INVALID_ARGUMENT` for invalid arguments, or
  -- * \return `RCUTILS_RET_STRING_MAP_INVALID` if the string map is invalid, or
  -- * \return `RCUTILS_RET_ERROR` if an unknown error occurs
  --  

   function rcutils_string_map_get_size (string_map : access constant rcutils_string_map_t; size : access rclx.stddef_h.size_t) return rclx.rcutils_types_rcutils_ret_h.rcutils_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:154
   pragma Import (C, rcutils_string_map_get_size, "rcutils_string_map_get_size");

  --/ Reserve a given amount of capacity in the map.
  --*
  -- * Increases the capacity of the map to at least the given size.
  -- *
  -- * If the current capacity is less than requested capacity then the capacity
  -- * is increased using the allocator given during initialization of the map in
  -- * rcutils_string_map_init().
  -- * If the requested capacity is less than the current capacity, the capacity
  -- * may be reduced, but no existing key value pairs will be truncated to do so.
  -- * In effect, the capacity will be shrunk to fit the number of items in map or
  -- * the requested capacity, which ever is larger.
  -- *
  -- * If recovering all resources is desired first call rcutils_string_map_clear()
  -- * and then this function with a capacity of 0.
  -- *
  -- * \param[inout] string_map rcutils_string_map_t to have space reserved in
  -- * \param[in] capacity requested size to reserve in the map
  -- * \return `RCUTILS_RET_OK` if successful, or
  -- * \return `RCUTILS_RET_INVALID_ARGUMENT` for invalid arguments, or
  -- * \return `RCUTILS_RET_BAD_ALLOC` if memory allocation fails, or
  -- * \return `RCUTILS_RET_STRING_MAP_INVALID` if the string map is invalid, or
  -- * \return `RCUTILS_RET_ERROR` if an unknown error occurs
  --  

   function rcutils_string_map_reserve (string_map : access rcutils_string_map_t; capacity : rclx.stddef_h.size_t) return rclx.rcutils_types_rcutils_ret_h.rcutils_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:182
   pragma Import (C, rcutils_string_map_reserve, "rcutils_string_map_reserve");

  --/ Remove all key value pairs from the map.
  --*
  -- * This function will remove all key value pairs from the map, and it will
  -- * reclaim all resources allocated as a result of setting key value pairs.
  -- * rcutils_string_map_fini() should still be called after this.
  -- *
  -- * \param[inout] string_map rcutils_string_map_t to be cleared
  -- * \return `RCUTILS_RET_OK` if successful, or
  -- * \return `RCUTILS_RET_INVALID_ARGUMENT` for invalid arguments, or
  -- * \return `RCUTILS_RET_STRING_MAP_INVALID` if the string map is invalid, or
  -- * \return `RCUTILS_RET_ERROR` if an unknown error occurs
  --  

   function rcutils_string_map_clear (string_map : access rcutils_string_map_t) return rclx.rcutils_types_rcutils_ret_h.rcutils_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:199
   pragma Import (C, rcutils_string_map_clear, "rcutils_string_map_clear");

  --/ Set a key value pair in the map, increasing capacity if necessary.
  --*
  -- * The capacity will be increased if needed using rcutils_string_map_reserve().
  -- * Otherwise it is the same as rcutils_string_map_set_no_resize().
  -- *
  -- * \see rcutils_string_map_set_no_resize()
  -- *
  -- * \param[inout] string_map rcutils_string_map_t to be updated
  -- * \param[in] key map key, must be null terminated c string
  -- * \param[in] value value for given map key, must be null terminated c string
  -- * \return `RCUTILS_RET_OK` if successful, or
  -- * \return `RCUTILS_RET_INVALID_ARGUMENT` for invalid arguments, or
  -- * \return `RCUTILS_RET_BAD_ALLOC` if memory allocation fails, or
  -- * \return `RCUTILS_RET_STRING_MAP_INVALID` if the string map is invalid, or
  -- * \return `RCUTILS_RET_ERROR` if an unknown error occurs
  --  

   function rcutils_string_map_set
     (string_map : access rcutils_string_map_t;
      key : Interfaces.C.Strings.chars_ptr;
      value : Interfaces.C.Strings.chars_ptr) return rclx.rcutils_types_rcutils_ret_h.rcutils_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:220
   pragma Import (C, rcutils_string_map_set, "rcutils_string_map_set");

  --/ Set a key value pair in the map but only if the map has enough capacity.
  --*
  -- * If the map already contains the given key, the existing value will be
  -- * replaced with the given value.
  -- * If the map does not contain the given key, and the map has additional
  -- * unused capacity, then it will store the given key and value in the map.
  -- * If there is no unused capacity in the map, then RCUTILS_RET_NOT_ENOUGH_SPACE
  -- * is returned.
  -- *
  -- * The given key and value c strings are copied into the map, and so storage is
  -- * allocated for them in the map when this function is called if necessary.
  -- * The storage allocated for this purpose is reclaimed either when
  -- * rcutils_string_map_fini() is called on this map or when using this function
  -- * or rcutils_string_map_unset().
  -- *
  -- * Any allocation that occurs in this functions uses the allocator of the map,
  -- * which is given when the map is initialized in rcutils_string_map_init().
  -- *
  -- * \param[inout] string_map rcutils_string_map_t to be updated
  -- * \param[in] key map key, must be null terminated c string
  -- * \param[in] value value for given map key, must be null terminated c string
  -- * \return `RCUTILS_RET_OK` if successful, or
  -- * \return `RCUTILS_RET_INVALID_ARGUMENT` for invalid arguments, or
  -- * \return `RCUTILS_RET_BAD_ALLOC` if memory allocation fails, or
  -- * \return `RCUTILS_RET_STRING_MAP_INVALID` if the string map is invalid, or
  -- * \return `RCUTILS_RET_NOT_ENOUGH_SPACE` if map is full, or
  -- * \return `RCUTILS_RET_ERROR` if an unknown error occurs
  --  

   function rcutils_string_map_set_no_resize
     (string_map : access rcutils_string_map_t;
      key : Interfaces.C.Strings.chars_ptr;
      value : Interfaces.C.Strings.chars_ptr) return rclx.rcutils_types_rcutils_ret_h.rcutils_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:253
   pragma Import (C, rcutils_string_map_set_no_resize, "rcutils_string_map_set_no_resize");

  --/ Unset a key value pair in the map.
  --*
  -- * The key needs to be a null terminated c string.
  -- * If the given key is not found, RCUTILS_RET_STRING_KEY_NOT_FOUND is returned.
  -- *
  -- * \param[inout] string_map rcutils_string_map_t to be updated
  -- * \param[in] key map key, must be null terminated c string
  -- * \return `RCUTILS_RET_OK` if successful, or
  -- * \return `RCUTILS_RET_INVALID_ARGUMENT` for invalid arguments, or
  -- * \return `RCUTILS_RET_STRING_MAP_INVALID` if the string map is invalid, or
  -- * \return `RCUTILS_RET_STRING_KEY_NOT_FOUND` if key not found, or
  -- * \return `RCUTILS_RET_ERROR` if an unknown error occurs
  --  

   function rcutils_string_map_unset (string_map : access rcutils_string_map_t; key : Interfaces.C.Strings.chars_ptr) return rclx.rcutils_types_rcutils_ret_h.rcutils_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:274
   pragma Import (C, rcutils_string_map_unset, "rcutils_string_map_unset");

  --/ Get whether or not a key exists.
  --*
  -- * The key needs to be a null terminated c string.
  -- *
  -- * This function can fail and return false if the key is not found,
  -- * or the string_map is NULL or invalid, or if the key is NULL.
  -- * In all cases no error message is set.
  -- *
  -- * \param[in] string_map rcutils_string_map_t to be searched
  -- * \param[in] key map key, must be null terminated c string
  -- * \return `true` if key is in the map, or
  -- * \return `false` if key is not in the map, or
  -- * \return `false` for invalid arguments, or
  -- * \return `false` if the string map is invalid
  --  

   function rcutils_string_map_key_exists (string_map : access constant rcutils_string_map_t; key : Interfaces.C.Strings.chars_ptr) return Extensions.bool;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:293
   pragma Import (C, rcutils_string_map_key_exists, "rcutils_string_map_key_exists");

  --/ Get whether or not a key of known length exists.
  --*
  -- * Identical to rcutils_string_map_key_exists() but without relying on key to be
  -- * a null terminated c string.
  -- *
  -- * \param[in] string_map rcutils_string_map_t to be searched
  -- * \param[in] key map key
  -- * \param[in] key_length map key length
  -- * \return `true` if key is in the map, or
  -- * \return `false` if key is not in the map, or
  -- * \return `false` for invalid arguments, or
  -- * \return `false` if the string map is invalid
  --  

   function rcutils_string_map_key_existsn
     (string_map : access constant rcutils_string_map_t;
      key : Interfaces.C.Strings.chars_ptr;
      key_length : rclx.stddef_h.size_t) return Extensions.bool;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:310
   pragma Import (C, rcutils_string_map_key_existsn, "rcutils_string_map_key_existsn");

  --/ Get value given a key.
  --*
  -- * The key needs to be a null terminated c string.
  -- *
  -- * This function can fail, and therefore return NULL, if the key is not found,
  -- * or the string_map is NULL or invalid, or if the key is NULL.
  -- * In all cases no error message is set.
  -- *
  -- * The returned value string is still owned by the map, and it should not be
  -- * modified or free'd.
  -- * This also means that the value pointer becomes invalid if either
  -- * rcutils_string_map_clear() or rcutils_string_map_fini() are called or if
  -- * the key value pair is updated or removed with one of rcutils_string_map_set()
  -- * or rcutils_string_map_set_no_resize() or rcutils_string_map_unset().
  -- *
  -- * \param[in] string_map rcutils_string_map_t to be searched
  -- * \param[in] key map key, must be null terminated c string
  -- * \return value for the given key if successful, or
  -- * \return `NULL` for invalid arguments, or
  -- * \return `NULL` if the string map is invalid, or
  -- * \return `NULL` if key not found, or
  -- * \return `NULL` if an unknown error occurs
  --  

   function rcutils_string_map_get (string_map : access constant rcutils_string_map_t; key : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:340
   pragma Import (C, rcutils_string_map_get, "rcutils_string_map_get");

  --/ Get value given a key and key length.
  --*
  -- * Identical to rcutils_string_map_get() but without relying on key to be a
  -- * null terminated c string.
  -- *
  -- * \param[in] string_map rcutils_string_map_t to be searched
  -- * \param[in] key map key
  -- * \param[in] key_length map key length
  -- * \return value for the given key if successful, or
  -- * \return `NULL` for invalid arguments, or
  -- * \return `NULL` if the string map is invalid, or
  -- * \return `NULL` if key not found, or
  -- * \return `NULL` if an unknown error occurs
  --  

   function rcutils_string_map_getn
     (string_map : access constant rcutils_string_map_t;
      key : Interfaces.C.Strings.chars_ptr;
      key_length : rclx.stddef_h.size_t) return Interfaces.C.Strings.chars_ptr;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:358
   pragma Import (C, rcutils_string_map_getn, "rcutils_string_map_getn");

  --/ Get the next key in the map, unless NULL is given, then get the first key.
  --*
  -- * This function allows you iteratively get each key in the map.
  -- *
  -- * If NULL is given for the key, then the first key in the map is returned.
  -- * If that returned key if given to the this function, then the next key in the
  -- * map is returned.
  -- * If there are no more keys in the map or if the given key is not in the map,
  -- * NULL is returned.
  -- *
  -- * The order of the keys in the map is arbitrary and if the map is modified
  -- * between calls to this function the behavior is undefined.
  -- * If the map is modifeid then iteration should begin again by passing NULL to
  -- * get the first key again.
  -- *
  -- * This function operates based on the address of the pointer, you cannot pass
  -- * a copy of a key to get the next key.
  -- *
  -- * Example:
  -- *
  -- * ```c
  -- * printf("keys in the map:\n");
  -- * const char * current_key = rcutils_string_map_get_next_key(&map, NULL);
  -- * while (current_key) {
  -- *   printf("  - %s\n", current_key);
  -- *   current_key = rcutils_string_map_get_next_key(&map, current_key);
  -- * }
  -- * ```
  -- *
  -- * NULL can also be returned if NULL is given for the string_map or if the
  -- * string_map is invalid.
  -- *
  -- * \param[in] string_map rcutils_string_map_t to be queried
  -- * \param[in] key NULL to get the first key or the previous key to get the next
  -- * \return value for the given key if successful, or
  -- * \return `NULL` for invalid arguments, or
  -- * \return `NULL` if the string map is invalid, or
  -- * \return `NULL` if key not found, or
  -- * \return `NULL` if there are no more keys in the map, or
  -- * \return `NULL` if an unknown error occurs
  --  

   function rcutils_string_map_get_next_key (string_map : access constant rcutils_string_map_t; key : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:406
   pragma Import (C, rcutils_string_map_get_next_key, "rcutils_string_map_get_next_key");

  --/ Copy all the key value pairs from one map into another, overwritting and resizing if needed.
  --*
  -- * If the destination string map does not have enough storage, then it is will
  -- * be resized.
  -- * If a key value pair exists in the destination map, its value will be
  -- * replaced with the source map's value.
  -- *
  -- * It is possible for only some of the values to be copied if an error happens
  -- * during the copying process, e.g. if memory allocation fails.
  -- *
  -- * \param[in] src_string_map rcutils_string_map_t to be copied from
  -- * \param[inout] dst_string_map rcutils_string_map_t to be copied to
  -- * \return `RCUTILS_RET_OK` if successful, or
  -- * \return `RCUTILS_RET_INVALID_ARGUMENT` for invalid arguments, or
  -- * \return `RCUTILS_RET_BAD_ALLOC` if memory allocation fails, or
  -- * \return `RCUTILS_RET_STRING_MAP_INVALID` if the string map is invalid, or
  -- * \return `RCUTILS_RET_ERROR` if an unknown error occurs
  --  

   function rcutils_string_map_copy (src_string_map : access constant rcutils_string_map_t; dst_string_map : access rcutils_string_map_t) return rclx.rcutils_types_rcutils_ret_h.rcutils_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcutils/types/string_map.h:431
   pragma Import (C, rcutils_string_map_copy, "rcutils_string_map_copy");

end rclx.rcutils_types_string_map_h;
