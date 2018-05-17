pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
limited with rclx.rcl_arguments_h;
with Interfaces.C.Strings;
with rclx.rcl_allocator_h;
with System;
with rclx.rcl_types_h;

package rclx.rcl_remap_h is

  -- Copyright 2018 Open Source Robotics Foundation, Inc.
  -- Licensed under the Apache License, Version 2.0 (the "License");
  -- you may not use this file except in compliance with the License.
  -- You may obtain a copy of the License at
  --     http://www.apache.org/licenses/LICENSE-2.0
  -- Unless required by applicable law or agreed to in writing, software
  -- distributed under the License is distributed on an "AS IS" BASIS,
  -- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  -- See the License for the specific language governing permissions and
  -- limitations under the License.
  -- TODO(sloretz) add documentation about rostopic:// when it is supported
  --/ Remap a topic name based on given rules.
  --*
  -- * The supplied topic name must have already been expanded to a fully qualified name.
  -- * \sa rcl_expand_topic_name()
  -- *
  -- * If `local_arguments` is not NULL and not zero intialized then its remap rules are checked first.
  -- * If no rules matched and `global_arguments` is not NULL and not zero intitialized then its rules
  -- * are checked next.
  -- * If both `local_arguments` and global_arguments are NULL or zero intialized then the function will
  -- * return RCL_RET_INVALID_ARGUMENT.
  -- *
  -- * `global_arguments` is usually the arguments passed to `rcl_init()`.
  -- * \sa rcl_init()
  -- * \sa rcl_get_global_arguments()
  -- *
  -- * Remap rules are checked in the order they were given.
  -- * For rules passed to `rcl_init` this usually is the order they were passed on the command line.
  -- * \sa rcl_parse_arguments()
  -- *
  -- * Only the first remap rule that matches is used to remap a name.
  -- * For example, if the command line arguments are `foo:=bar bar:=baz` the topic `foo` is remapped to
  -- * `bar` and not `baz`.
  -- *
  -- * `node_name` and `node_namespace` are used to expand the match and replacement into fully
  -- * qualified names.
  -- * Given node_name `trudy`, namespace `/ns`, and rule `foo:=~/bar` the names in the rule are
  -- * expanded to `/ns/foo:=/ns/trudy/bar`.
  -- * The rule will only apply if the given topic name is `/ns/foo`.
  -- *
  -- * `node_name` is also used to match against node specific rules.
  -- * Given rules `alice:foo:=bar foo:=baz`, node name `alice`, and topic `foo` the remapped topic
  -- * name will be `bar`.
  -- * If given the node name `bob` and topic `foo` the remaped topic name would be `baz` instead.
  -- * Note that processing always stops at the first matching rule even if there is a more specific one
  -- * later on.
  -- * Given `foo:=bar alice:foo:=baz` and topic name `foo` the remapped topic name will always be
  -- * `bar` regardless of the node name given.
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | Yes
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Yes
  -- *
  -- * \param[in] local_arguments Command line arguments to be used before global arguments, or
  -- *   if NULL or zero-initialized then only global arguments are used.
  -- * \param[in] global_arguments Command line arguments to use if no local rules matched, or
  -- *   `NULL` or zero-initialized to ignore global arguments.
  -- * \param[in] topic_name A fully qualified and expanded topic name to be remapped.
  -- * \param[in] node_name The name of the node to which name belongs.
  -- * \param[in] node_namespace The namespace of a node to which name belongs.
  -- * \param[in] allocator A valid allocator to use.
  -- * \param[out] output_name Either an allocated string with the remapped name, or
  -- *   `NULL` if no remap rules matched the name.
  -- * \return `RCL_RET_OK` if the topic name was remapped or no rules matched, or
  -- * \return `RCL_RET_INVALID_ARGUMENT` if any arguments are invalid, or
  -- * \return `RCL_RET_BAD_ALLOC` if allocating memory failed, or
  -- * \return `RCL_RET_TOPIC_NAME_INVALID` if the given topic name is invalid, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_remap_topic_name
     (local_arguments : access constant rclx.rcl_arguments_h.rcl_arguments_t;
      global_arguments : access constant rclx.rcl_arguments_h.rcl_arguments_t;
      topic_name : Interfaces.C.Strings.chars_ptr;
      node_name : Interfaces.C.Strings.chars_ptr;
      node_namespace : Interfaces.C.Strings.chars_ptr;
      allocator : rclx.rcl_allocator_h.rcl_allocator_t;
      output_name : System.Address) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/remap.h:95
   pragma Import (C, rcl_remap_topic_name, "rcl_remap_topic_name");

  -- TODO(sloretz) add documentation about rosservice:// when it is supported
  --/ Remap a service name based on given rules.
  --*
  -- * The supplied service name must have already been expanded to a fully qualified name.
  -- *
  -- * The behavior of this function is identical to rcl_expand_topic_name() except that it applies
  -- * to service names instead of topic names.
  -- * \sa rcl_expand_topic_name()
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | Yes
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Yes
  -- *
  -- * \param[in] local_arguments Command line arguments to be used before global arguments, or
  -- *   if NULL or zero-initialized then only global arguments are used.
  -- * \param[in] global_arguments Command line arguments to use if no local rules matched, or
  -- *   `NULL` or zero-initialized to ignore global arguments.
  -- * \param[in] service_name A fully qualified and expanded service name to be remapped.
  -- * \param[in] node_name The name of the node to which name belongs.
  -- * \param[in] node_namespace The namespace of a node to which name belongs.
  -- * \param[in] allocator A valid allocator to use.
  -- * \param[out] output_name Either an allocated string with the remapped name, or
  -- *   `NULL` if no remap rules matched the name.
  -- * \return `RCL_RET_OK` if the name was remapped or no rules matched, or
  -- * \return `RCL_RET_INVALID_ARGUMENT` if any arguments are invalid, or
  -- * \return `RCL_RET_BAD_ALLOC` if allocating memory failed, or
  -- * \return `RCL_RET_SERVICE_NAME_INVALID` if the given name is invalid, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_remap_service_name
     (local_arguments : access constant rclx.rcl_arguments_h.rcl_arguments_t;
      global_arguments : access constant rclx.rcl_arguments_h.rcl_arguments_t;
      serivice_name : Interfaces.C.Strings.chars_ptr;
      node_name : Interfaces.C.Strings.chars_ptr;
      node_namespace : Interfaces.C.Strings.chars_ptr;
      allocator : rclx.rcl_allocator_h.rcl_allocator_t;
      output_name : System.Address) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/remap.h:140
   pragma Import (C, rcl_remap_service_name, "rcl_remap_service_name");

  --/ Remap a node name based on given rules.
  --*
  -- * This function returns the node name that a node with the given name would be remapped to.
  -- * When a node's name is remapped it changes its logger name and the output of expanding relative
  -- * topic and service names.
  -- *
  -- * When composing nodes make sure that the final node names used are unique per process.
  -- * There is not currently a way to independently remap the names of two nodes that were created
  -- * with the same node name and are manually composed into one process.
  -- *
  -- * The behavior of `local_arguments`, `global_arguments`, `node_name`, the order remap rules are
  -- * applied, and node specific rules is identical to rcl_remap_topic_name().
  -- * \sa rcl_remap_topic_name()
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | Yes
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Yes
  -- *
  -- * \param[in] local_arguments Arguments to be used before global arguments.
  -- * \param[in] global_arguments Command line arguments to use if no local rules matched, or
  -- *   `NULL` or zero-initialized to ignore global arguments.
  -- * \param[in] node_name The current name of the node.
  -- * \param[in] allocator A valid allocator to use.
  -- * \param[out] output_name Either an allocated string with the remapped name, or
  -- *   `NULL` if no remap rules matched the name.
  -- * \return `RCL_RET_OK` If the name was remapped or no rules matched, or
  -- * \return `RCL_RET_INVALID_ARGUMENT` if any arguments are invalid, or
  -- * \return `RCL_RET_BAD_ALLOC` if allocating memory failed, or
  -- * \return `RCL_RET_NODE_INVALID_NAME` if the name is invalid, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_remap_node_name
     (local_arguments : access constant rclx.rcl_arguments_h.rcl_arguments_t;
      global_arguments : access constant rclx.rcl_arguments_h.rcl_arguments_t;
      node_name : Interfaces.C.Strings.chars_ptr;
      allocator : rclx.rcl_allocator_h.rcl_allocator_t;
      output_name : System.Address) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/remap.h:187
   pragma Import (C, rcl_remap_node_name, "rcl_remap_node_name");

  --/ Remap a namespace based on given rules.
  --*
  -- * This function returns the namespace that a node with the given name would be remapped to.
  -- * When a node's namespace is remapped it changes its logger name and the output of expanding
  -- * relative topic and service names.
  -- *
  -- * The behavior of `local_arguments`, `global_arguments`, `node_name`, the order remap rules are
  -- * applied, and node specific rules is identical to rcl_remap_topic_name().
  -- * \sa rcl_remap_topic_name()
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | Yes
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Yes
  -- *
  -- * \param[in] local_arguments Arguments to be used before global arguments.
  -- * \param[in] global_arguments Command line arguments to use if no local rules matched, or
  -- *   `NULL` or zero-initialized to ignore global arguments.
  -- * \param[in] node_name The name of the node whose namespace is being remapped.
  -- * \param[in] allocator A valid allocator to be used.
  -- * \param[out] output_namespace Either an allocated string with the remapped namespace, or
  -- *   `NULL` if no remap rules matched the name.
  -- * \return `RCL_RET_OK` if the node name was remapped or no rules matched, or
  -- * \return `RCL_RET_INVALID_ARGUMENT` if any arguments are invalid, or
  -- * \return `RCL_RET_BAD_ALLOC` if allocating memory failed, or
  -- * \return `RCL_RET_NODE_INVALID_NAMESPACE` if the remapped namespace is invalid, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_remap_node_namespace
     (local_arguments : access constant rclx.rcl_arguments_h.rcl_arguments_t;
      global_arguments : access constant rclx.rcl_arguments_h.rcl_arguments_t;
      node_name : Interfaces.C.Strings.chars_ptr;
      allocator : rclx.rcl_allocator_h.rcl_allocator_t;
      output_namespace : System.Address) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/remap.h:228
   pragma Import (C, rcl_remap_node_namespace, "rcl_remap_node_namespace");

end rclx.rcl_remap_h;