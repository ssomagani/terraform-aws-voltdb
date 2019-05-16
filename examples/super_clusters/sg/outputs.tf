output "voltdb_public_id" {
  value       = "${aws_security_group.voltdb_public.id}"
  description = "Public SG"
}

output "voltdb_private_id" {
  value       = "${aws_security_group.voltdb_private.id}"
  description = "Private SG"
}
