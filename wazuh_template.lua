function append_wazuh_template(tag, timestamp, record)
    local template = {
        order = 0,
        index_patterns = {"wazuh-alerts-4.x-*", "wazuh-archives-4.x-*"},
        settings = {
            ["index.refresh_interval"] = "5s",
            ["index.number_of_shards"] = "3",
            ["index.number_of_replicas"] = "0",
            ["index.auto_expand_replicas"] = "0-1",
            ["index.mapping.total_fields.limit"] = 10000
        },
        mappings = {
            dynamic_templates = {
                {
                    string_as_keyword = {
                        mapping = {
                            type = "keyword"
                        },
                        match_mapping_type = "string"
                    }
                }
            },
            date_detection = false,
            properties = {
                ["@timestamp"] = { type = "date" },
                timestamp = {
                    type = "date",
                    format = "date_optional_time||epoch_millis"
                },
                ["@version"] = { type = "text" },
                agent = {
                    properties = {
                        ip = { type = "keyword" },
                        id = { type = "keyword" },
                        name = { type = "keyword" }
                    }
                },
                manager = {
                    properties = {
                        name = { type = "keyword" }
                    }
                },
                cluster = {
                    properties = {
                        name = { type = "keyword" },
                        node = { type = "keyword" }
                    }
                },
                full_log = { type = "text" },
                previous_log = { type = "text" },
                -- Add all other properties from the template here
                -- ...
            }
        },
        version = 1
    }

    -- Add the 'query.default_field' setting
    template.settings["index.query.default_field"] = {
        "GeoLocation.city_name",
        "GeoLocation.continent_code",
        "GeoLocation.country_code2",
        "GeoLocation.country_code3",
        "GeoLocation.country_name",
        "GeoLocation.ip",
        "GeoLocation.postal_code",
        "GeoLocation.real_region_name",
        "GeoLocation.region_name",
        "GeoLocation.timezone",
        "agent.id",
        "agent.ip",
        "agent.name",
        "cluster.name",
        "cluster.node",
        "command",
        "data",
        "data.action",
        "data.audit",
        "data.audit.acct",
        "data.audit.arch",
        "data.audit.auid",
        "data.audit.command",
        "data.audit.cwd",
        "data.audit.dev",
        "data.audit.directory.inode",
        "data.audit.directory.mode",
        "data.audit.directory.name",
        "data.audit.egid",
        "data.audit.enforcing",
        "data.audit.euid",
        "data.audit.exe",
        "data.audit.execve.a0",
        "data.audit.execve.a1",
        "data.audit.execve.a2",
        "data.audit.execve.a3",
        "data.audit.exit",
        "data.audit.file.inode",
        "data.audit.file.mode",
        "data.audit.file.name",
        "data.audit.fsgid",
        "data.audit.fsuid",
        "data.audit.gid",
        "data.audit.id",
        "data.audit.key",
        "data.audit.list",
        "data.audit.old-auid",
        "data.audit.old-ses",
        "data.audit.old_enforcing",
        "data.audit.old_prom",
        "data.audit.op",
        "data.audit.pid",
        "data.audit.ppid",
        "data.audit.prom",
        "data.audit.res",
        "data.audit.session",
        "data.audit.sgid",
        "data.audit.srcip",
        "data.audit.subj",
        "data.audit.success",
        "data.audit.suid",
        "data.audit.syscall",
        "data.audit.tty",
        "data.audit.uid",
        "data.aws.accountId",
        "data.aws.account_id",
        "data.aws.action",
        "data.aws.actor",
        "data.aws.aws_account_id",
        "data.aws.description",
        "data.aws.dstport",
        "data.aws.errorCode",
        "data.aws.errorMessage",
        "data.aws.eventID",
        "data.aws.eventName",
        "data.aws.eventSource",
        "data.aws.eventType",
        "data.aws.id",
        "data.aws.name",
        "data.aws.requestParameters.accessKeyId",
        "data.aws.requestParameters.bucketName",
        "data.aws.requestParameters.gatewayId",
        "data.aws.requestParameters.groupDescription",
        "data.aws.requestParameters.groupId",
        "data.aws.requestParameters.groupName",
        "data.aws.requestParameters.host",
        "data.aws.requestParameters.hostedZoneId",
        "data.aws.requestParameters.instanceId",
        "data.aws.requestParameters.instanceProfileName",
        "data.aws.requestParameters.loadBalancerName",
        "data.aws.requestParameters.loadBalancerPorts",
        "data.aws.requestParameters.masterUserPassword",
        "data.aws.requestParameters.masterUsername",
        "data.aws.requestParameters.name",
        "data.aws.requestParameters.natGatewayId",
        "data.aws.requestParameters.networkAclId",
        "data.aws.requestParameters.path",
        "data.aws.requestParameters.policyName",
        "data.aws.requestParameters.port",
        "data.aws.requestParameters.stackId",
        "data.aws.requestParameters.stackName",
        "data.aws.requestParameters.subnetId",
        "data.aws.requestParameters.subnetIds",
        "data.aws.requestParameters.volumeId",
        "data.aws.requestParameters.vpcId",
        "data.aws.resource.accessKeyDetails.accessKeyId",
        "data.aws.resource.accessKeyDetails.principalId",
        "data.aws.resource.accessKeyDetails.userName",
        "data.aws.resource.instanceDetails.instanceId",
        "data.aws.resource.instanceDetails.instanceState",
        "data.aws.resource.instanceDetails.networkInterfaces.privateDnsName",
        "data.aws.resource.instanceDetails.networkInterfaces.publicDnsName",
        "data.aws.resource.instanceDetails.networkInterfaces.subnetId",
        "data.aws.resource.instanceDetails.networkInterfaces.vpcId",
        "data.aws.resource.instanceDetails.tags.value",
        "data.aws.responseElements.AssociateVpcCidrBlockResponse.vpcId",
        "data.aws.responseElements.description",
        "data.aws.responseElements.instanceId",
        "data.aws.responseElements.instances.instanceId",
        "data.aws.responseElements.instancesSet.items.instanceId",
        "data.aws.responseElements.listeners.port",
        "data.aws.responseElements.loadBalancerName",
        "data.aws.responseElements.loadBalancers.vpcId",
        "data.aws.responseElements.loginProfile.userName",
        "data.aws.responseElements.networkAcl.vpcId",
        "data.aws.responseElements.ownerId",
        "data.aws.responseElements.publicIp",
        "data.aws.responseElements.user.userId",
        "data.aws.responseElements.user.userName",
        "data.aws.responseElements.volumeId",
        "data.aws.service.serviceName",
        "data.aws.severity",
        "data.aws.source",
        "data.aws.sourceIPAddress",
        "data.aws.srcport",
        "data.aws.userIdentity.accessKeyId",
        "data.aws.userIdentity.accountId",
        "data.aws.userIdentity.userName",
        "data.aws.vpcEndpointId",
        "data.command",
        "data.cis.group",
        "data.cis.rule_title",
        "data.data",
        "data.docker.Actor.Attributes.container",
        "data.docker.Actor.Attributes.image",
        "data.docker.Actor.Attributes.name",
        "data.docker.Actor.ID",
        "data.docker.id",
        "data.docker.message",
        "data.docker.status",
        "data.dstip",
        "data.dstport",
        "data.dstuser",
        "data.extra_data",
        "data.gcp.jsonPayload.queryName",
        "data.gcp.jsonPayload.vmInstanceName",
        "data.gcp.resource.labels.location",
        "data.gcp.resource.labels.project_id",
        "data.gcp.resource.labels.source_type",
        "data.gcp.resource.type",
        "data.github.org",
        "data.github.actor",
        "data.github.action",
        "data.github.repo",
        "data.hardware.serial",
        "data.id",
        "data.integration",
        "data.netinfo.iface.adapter",
        "data.netinfo.iface.ipv4.address",
        "data.netinfo.iface.ipv6.address",
        "data.netinfo.iface.mac",
        "data.netinfo.iface.name",
        "data.office365.Actor.ID",
        "data.office365.UserId",
        "data.office365.Operation",
        "data.office365.ClientIP",
        "data.ms-graph.relationship",
        "data.ms-graph.classification",
        "data.ms-graph.detectionSource",
        "data.ms-graph.determination",
        "data.ms-graph.remediationStatus",
        "data.ms-graph.roles",
        "data.ms-graph.verdict",
        "data.ms-graph.serviceSource",
        "data.ms-graph.severity",
        "data.ms-graph.actorDisplayName",
        "data.ms-graph.alertWebUrl",
        "data.ms-graph.assignedTo",
        "data.ms-graph.category",
        "data.ms-graph.comments",
        "data.ms-graph.description",
        "data.ms-graph.detectorId",
        "data.ms-graph.evidence._comment",
        "data.ms-graph.id",
        "data.ms-graph.incidentId",
        "data.ms-graph.incidentWebUrl",
        "data.ms-graph.mitreTechniques",
        "data.ms-graph.providerAlertId",
        "data.ms-graph.resource",
        "data.ms-graph.status",
        "data.ms-graph.tenantId",
        "data.ms-graph.threatDisplayName",
        "data.ms-graph.threatFamilyName",
        "data.ms-graph.title",
        "data.ms-graph.appliedConditionalAccessPolicies",
        "data.os.architecture",
        "data.os.build",
        "data.os.codename",
        "data.os.hostname",
        "data.os.major",
        "data.os.minor",
        "data.os.patch",
        "data.os.name",
        "data.os.platform",
        "data.os.release",
        "data.os.release_version",
        "data.os.display_version",
        "data.os.sysname",
        "data.os.version",
        "data.oscap.check.description",
        "data.oscap.check.id",
        "data.oscap.check.identifiers",
        "data.oscap.check.oval.id",
        "data.oscap.check.rationale",
        "data.oscap.check.references",
        "data.oscap.check.result",
        "data.oscap.check.severity",
        "data.oscap.check.title",
        "data.oscap.scan.benchmark.id",
        "data.oscap.scan.content",
        "data.oscap.scan.id",
        "data.oscap.scan.profile.id",
        "data.oscap.scan.profile.title",
        "data.osquery.columns.address",
        "data.osquery.columns.command",
        "data.osquery.columns.description",
        "data.osquery.columns.dst_ip",
        "data.osquery.columns.gid",
        "data.osquery.columns.hostname",
        "data.osquery.columns.md5",
        "data.osquery.columns.path",
        "data.osquery.columns.sha1",
        "data.osquery.columns.sha256",
        "data.osquery.columns.src_ip",
        "data.osquery.columns.user",
        "data.osquery.columns.username",
        "data.osquery.name",
        "data.osquery.pack",
        "data.port.process",
        "data.port.protocol",
        "data.port.state",
        "data.process.args",
        "data.process.cmd",
        "data.process.egroup",
        "data.process.euser",
        "data.process.fgroup",
        "data.process.name",
        "data.process.rgroup",
        "data.process.ruser",
        "data.process.sgroup",
        "data.process.state",
        "data.process.suser",
        "data.program.architecture",
        "data.program.description",
        "data.program.format",
        "data.program.location",
        "data.program.multiarch",
        "data.program.name",
        "data.program.priority",
        "data.program.section",
        "data.program.source",
        "data.program.vendor",
        "data.program.version",
        "data.protocol",
        "data.pwd",
        "data.sca",
        "data.sca.check.compliance.cis",
        "data.sca.check.compliance.cis_csc",
        "data.sca.check.compliance.pci_dss",
        "data.sca.check.compliance.hipaa",
        "data.sca.check.compliance.nist_800_53",
        "data.sca.check.description",
        "data.sca.check.directory",
        "data.sca.check.file",
        "data.sca.check.id",
        "data.sca.check.previous_result",
        "data.sca.check.process",
        "data.sca.check.rationale",
        "data.sca.check.reason",
        "data.sca.check.references",
        "data.sca.check.registry",
        "data.sca.check.remediation",
        "data.sca.check.result",
        "data.sca.check.title",
        "data.sca.description",
        "data.sca.file",
        "data.sca.invalid",
        "data.sca.name",
        "data.sca.policy",
        "data.sca.policy_id",
        "data.sca.scan_id",
        "data.sca.total_checks",
        "data.script",
        "data.src_ip",
        "data.src_port",
        "data.srcip",
        "data.srcport",
        "data.srcuser",
        "data.status",
        "data.system_name",
        "data.title",
        "data.tty",
        "data.uid",
        "data.url",
        "data.virustotal.description",
        "data.virustotal.error",
        "data.virustotal.found",
        "data.virustotal.permalink",
        "data.virustotal.scan_date",
        "data.virustotal.sha1",
        "data.virustotal.source.alert_id",
        "data.virustotal.source.file",
        "data.virustotal.source.md5",
        "data.virustotal.source.sha1",
        "data.vulnerability.cve",
        "data.vulnerability.cvss.cvss2.base_score",
        "data.vulnerability.cvss.cvss2.exploitability_score",
        "data.vulnerability.cvss.cvss2.impact_score",
        "data.vulnerability.cvss.cvss2.vector.access_complexity",
        "data.vulnerability.cvss.cvss2.vector.attack_vector",
        "data.vulnerability.cvss.cvss2.vector.authentication",
        "data.vulnerability.cvss.cvss2.vector.availability",
        "data.vulnerability.cvss.cvss2.vector.confidentiality_impact",
        "data.vulnerability.cvss.cvss2.vector.integrity_impact",
        "data.vulnerability.cvss.cvss2.vector.privileges_required",
        "data.vulnerability.cvss.cvss2.vector.scope",
        "data.vulnerability.cvss.cvss2.vector.user_interaction",
        "data.vulnerability.cvss.cvss3.base_score",
        "data.vulnerability.cvss.cvss3.exploitability_score",
        "data.vulnerability.cvss.cvss3.impact_score",
        "data.vulnerability.cvss.cvss3.vector.access_complexity",
        "data.vulnerability.cvss.cvss3.vector.attack_vector",
        "data.vulnerability.cvss.cvss3.vector.authentication",
        "data.vulnerability.cvss.cvss3.vector.availability",
        "data.vulnerability.cvss.cvss3.vector.confidentiality_impact",
        "data.vulnerability.cvss.cvss3.vector.integrity_impact",
        "data.vulnerability.cvss.cvss3.vector.privileges_required",
        "data.vulnerability.cvss.cvss3.vector.scope",
        "data.vulnerability.cvss.cvss3.vector.user_interaction",
        "data.vulnerability.cwe_reference",
        "data.vulnerability.package.source",
        "data.vulnerability.package.architecture",
        "data.vulnerability.package.condition",
        "data.vulnerability.package.generated_cpe",
        "data.vulnerability.package.name",
        "data.vulnerability.package.version",
        "data.vulnerability.rationale",
        "data.vulnerability.severity",
        "data.vulnerability.title",
        "data.vulnerability.assigner",
        "data.vulnerability.cve_version",
        "data.win.eventdata.auditPolicyChanges",
        "data.win.eventdata.auditPolicyChangesId",
        "data.win.eventdata.binary",
        "data.win.eventdata.category",
        "data.win.eventdata.categoryId",
        "data.win.eventdata.data",
        "data.win.eventdata.image",
        "data.win.eventdata.ipAddress",
        "data.win.eventdata.ipPort",
        "data.win.eventdata.keyName",
        "data.win.eventdata.logonGuid",
        "data.win.eventdata.logonProcessName",
        "data.win.eventdata.operation",
        "data.win.eventdata.parentImage",
        "data.win.eventdata.processId",
        "data.win.eventdata.processName",
        "data.win.eventdata.providerName",
        "data.win.eventdata.returnCode",
        "data.win.eventdata.service",
        "data.win.eventdata.status",
        "data.win.eventdata.subcategory",
        "data.win.eventdata.subcategoryGuid",
        "data.win.eventdata.subcategoryId",
        "data.win.eventdata.subjectDomainName",
        "data.win.eventdata.subjectLogonId",
        "data.win.eventdata.subjectUserName",
        "data.win.eventdata.subjectUserSid",
        "data.win.eventdata.targetDomainName",
        "data.win.eventdata.targetLinkedLogonId",
        "data.win.eventdata.targetLogonId",
        "data.win.eventdata.targetUserName",
        "data.win.eventdata.targetUserSid",
        "data.win.eventdata.workstationName",
        "data.win.system.channel",
        "data.win.system.computer",
        "data.win.system.eventID",
        "data.win.system.eventRecordID",
        "data.win.system.eventSourceName",
        "data.win.system.keywords",
        "data.win.system.level",
        "data.win.system.message",
        "data.win.system.opcode",
        "data.win.system.processID",
        "data.win.system.providerGuid",
        "data.win.system.providerName",
        "data.win.system.securityUserID",
        "data.win.system.severityValue",
        "data.win.system.userID",
        "decoder.ftscomment",
        "decoder.name",
        "decoder.parent",
        "full_log",
        "host",
        "id",
        "input",
        "location",
        "manager.name",
        "message",
        "offset",
        "predecoder.hostname",
        "predecoder.program_name",
        "previous_log",
        "previous_output",
        "program_name",
        "rule.cis",
        "rule.cve",
        "rule.description",
        "rule.gdpr",
        "rule.gpg13",
        "rule.groups",
        "rule.id",
        "rule.info",
        "rule.mitre.id",
        "rule.mitre.tactic",
        "rule.mitre.technique",
        "rule.pci_dss",
        "rule.hipaa",
        "rule.nist_800_53",
        "syscheck.audit.effective_user.id",
        "syscheck.audit.effective_user.name",
        "syscheck.audit.group.id",
        "syscheck.audit.group.name",
        "syscheck.audit.login_user.id",
        "syscheck.audit.login_user.name",
        "syscheck.audit.process.id",
        "syscheck.audit.process.name",
        "syscheck.audit.process.ppid",
        "syscheck.audit.user.id",
        "syscheck.audit.user.name",
        "syscheck.diff",
        "syscheck.event",
        "syscheck.gid_after",
        "syscheck.gid_before",
        "syscheck.gname_after",
        "syscheck.gname_before",
        "syscheck.inode_after",
        "syscheck.inode_before",
        "syscheck.md5_after",
        "syscheck.md5_before",
        "syscheck.path",
        "syscheck.mode",
        "syscheck.perm_after",
        "syscheck.perm_before",
        "syscheck.sha1_after",
        "syscheck.sha1_before",
        "syscheck.sha256_after",
        "syscheck.sha256_before",
        "syscheck.tags",
        "syscheck.uid_after",
        "syscheck.uid_before",
        "syscheck.uname_after",
        "syscheck.uname_before",
        "syscheck.arch",
        "syscheck.value_name",
        "syscheck.value_type",
        "syscheck.changed_attributes",
        "title"
    }

    -- Determine the index name based on the tag
    local index_name
    if tag == "wazuh-alerts" then
        index_name = "wazuh-alerts-4.x-" .. os.date("%Y.%m.%d")
    elseif tag == "wazuh-archives" then
        index_name = "wazuh-archives-4.x-" .. os.date("%Y.%m.%d")
    else
        index_name = "wazuh-unknown-4.x-" .. os.date("%Y.%m.%d")
    end

    -- Add the template to the record
    record["_index_template"] = {
        [index_name] = template
    }

    return 1, timestamp, record
end
