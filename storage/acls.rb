# Copyright 2017 Google, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

def print_bucket_acl project_id:, bucket_name:
  # [START print_bucket_acl]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Your Google Cloud Storage bucket name"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  puts "ACL for #{bucket_name}:"

  bucket.acl.owners.each do |owner|
    puts "\tOWNER #{owner}"
  end

  bucket.acl.writers.each do |writer|
    puts "\tWRITER #{writer}"
  end

  bucket.acl.readers.each do |reader|
    puts "\tREADER #{reader}"
  end
  # [END print_bucket_acl]
end

def print_bucket_acl_for_user project_id:, bucket_name:, email:
  # [START print_bucket_acl_for_user]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Your Google Cloud Storage bucket name"
  # email       = "Email to associate with permissions"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  puts "Permissions for #{email}:"
  puts "\tOWNER"  if bucket.acl.owners.include?  email
  puts "\tWRITER" if bucket.acl.writers.include? email
  puts "\tREADER" if bucket.acl.readers.include? email
  # [END print_bucket_acl_for_user]
end

def add_bucket_owner project_id:, bucket_name:, email:
  # [START add_bucket_owner]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Your Google Cloud Storage bucket name"
  # email       = "Email to associate with permissions"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.acl.add_owner email

  puts "Added OWNER permission for #{email} to #{bucket_name}"
  # [END add_bucket_owner]
end

def remove_bucket_owner project_id:, bucket_name:, email:
  # [START remove_bucket_owner]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Your Google Cloud Storage bucket name"
  # email       = "Email to associate with permissions"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.acl.delete email

  puts "Removed OWNER permission for #{email} from #{bucket_name}"
  # [END remove_bucket_owner]
end

def add_bucket_default_owner project_id:, bucket_name:, email:
  # [START add_bucket_default_owner]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Your Google Cloud Storage bucket name"
  # email       = "Email to associate with permissions"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.default_acl.add_owner email

  puts "Added default OWNER permission for #{email} to #{bucket_name}"
  # [END add_bucket_default_owner]
end

def remove_bucket_default_owner project_id:, bucket_name:, email:
  # [START remove_bucket_default_owner]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Your Google Cloud Storage bucket name"
  # email       = "Email to associate with permissions"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name

  bucket.default_acl.delete email

  puts "Removed default OWNER permission for #{email} from #{bucket_name}"
  # [END remove_bucket_default_owner]
end

def print_file_acl project_id:, bucket_name:, file_name:
  # [START print_file_acl]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Your Google Cloud Storage bucket name"
  # file_name   = "Name of a file in the Storage bucket"
  # email       = "Email to associate with permissions"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name
  file    = bucket.file file_name

  puts "ACL for #{file_name} in #{bucket_name}:"

  file.acl.owners.each do |owner|
    puts "\tOWNER #{owner}"
  end

  file.acl.readers.each do |reader|
    puts "\tREADER #{reader}"
  end
  # [END print_file_acl]
end

def print_file_acl_for_user project_id:, bucket_name:, file_name:, email:
  # [START print_file_acl_for_user]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Your Google Cloud Storage bucket name"
  # file_name   = "Name of a file in the Storage bucket"
  # email       = "Email to associate with permissions"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name
  file    = bucket.file file_name

  puts "Permissions for #{email}:"
  puts "\tOWNER"  if file.acl.owners.include?  email
  puts "\tREADER" if file.acl.readers.include? email
  # [END print_file_acl_for_user]
end

def add_file_owner project_id:, bucket_name:, file_name:, email:
  # [START add_file_owner]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Your Google Cloud Storage bucket name"
  # file_name   = "Name of a file in the Storage bucket"
  # email       = "Email to associate with permissions"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name
  file    = bucket.file file_name

  file.acl.add_owner email

  puts "Added OWNER permission for #{email} to #{file_name}"
  # [END add_file_owner]
end

def remove_file_owner project_id:, bucket_name:, file_name:, email:
  # [START remove_file_owner]
  # project_id  = "Your Google Cloud project ID"
  # bucket_name = "Your Google Cloud Storage bucket name"
  # file_name   = "Name of a file in the Storage bucket"
  # email       = "Email to associate with permissions"

  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new project: project_id
  bucket  = storage.bucket bucket_name
  file    = bucket.file file_name

  file.acl.delete email

  puts "Removed OWNER permission for #{email} from #{file_name}"
  # [END remove_file_owner]
end

def run_sample arguments
  command = arguments.shift
  project_id = ENV["GOOGLE_CLOUD_PROJECT"]

  case command
  when "print_bucket_acl"
    print_bucket_acl(project_id: project_id,
                     bucket_name: arguments.shift)
  when "print_bucket_acl_for_user"
    print_bucket_acl_for_user(project_id: project_id,
                              bucket_name: arguments.shift,
                              email: arguments.shift)
  when "add_bucket_owner"
    add_bucket_owner(project_id: project_id,
                     bucket_name: arguments.shift,
                     email: arguments.shift)
  when "remove_bucket_owner"
    remove_bucket_owner(project_id: project_id,
                        bucket_name: arguments.shift,
                        email: arguments.shift)
  when "add_bucket_default_owner"
    add_bucket_default_owner(project_id: project_id,
                             bucket_name: arguments.shift,
                             email: arguments.shift)
  when "remove_bucket_default_owner"
    remove_bucket_default_owner(project_id: project_id,
                                bucket_name: arguments.shift,
                                email: arguments.shift)
  when "print_file_acl"
    print_file_acl(project_id: project_id,
                   bucket_name: arguments.shift,
                   file_name: arguments.shift)
  when "print_file_acl_for_user"
    print_file_acl_for_user(project_id: project_id,
                            bucket_name: arguments.shift,
                            file_name: arguments.shift,
                            email: arguments.shift)
  when "add_file_owner"
    add_file_owner(project_id: project_id,
                   bucket_name: arguments.shift,
                   file_name: arguments.shift,
                   email: arguments.shift)
  when "remove_file_owner"
    remove_file_owner(project_id: project_id,
                      bucket_name: arguments.shift,
                      file_name: arguments.shift,
                      email: arguments.shift)
  else
    puts <<-usage
Usage: bundle exec ruby acls.rb [command] [arguments]

Commands:
  print_bucket_acl <bucket>                  Print bucket Access Control List
  print_bucket_acl_for_user <bucket> <email> Print bucket ACL for an email
  add_bucket_owner <bucket> <email>          Add a new OWNER to a bucket
  remove_bucket_owner <bucket> <email>       Remove an OWNER from a bucket
  add_bucket_default_owner <bucket> <email>  Add a default OWNER for a bucket
  remove_bucket_default_owner <bucket> <email> Remove a default OWNER from a bucket
  print_file_acl <bucket> <file>               Print file ACL
  print_file_acl_for_user <bucket> <file> <email> Print file ACL for an email
  add_file_owner <bucket> <file> <email>          Add an OWNER to a file
  remove_file_owner <bucket> <file> <email>       Remove an OWNER from a file

Environment variables:
  GOOGLE_CLOUD_PROJECT must be set to your Google Cloud project ID
    usage
  end
end

if __FILE__ == $PROGRAM_NAME
  run_sample ARGV
end

