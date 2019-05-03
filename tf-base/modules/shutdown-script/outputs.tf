output content {
  description = "rendered shutdown script"
  value       = "${data.template_file.shutdown_script.rendered}"
}
