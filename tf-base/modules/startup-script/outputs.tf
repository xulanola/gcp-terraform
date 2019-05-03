output content {
  description = "rendered startup script"
  value       = "${data.template_file.startup_script.rendered}"
}
