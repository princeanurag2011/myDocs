# KOPS - Kubernetes Operations!!

kops is Kubernetes ops.

 kops is the easiest way to get a production grade Kubernetes cluster up and running. We like to think of it as kubectl for clusters.

 kops helps you create, destroy, upgrade and maintain production-grade, highly available, Kubernetes clusters from the command line.  AWS (Amazon Web Services) is currently officially supported, with GCE and VMware vSphere in alpha support.

Usage:
  kops [command]

Available Commands:
  completion     Output shell completion code for the given shell (bash or zsh).
  create         Create a resource by command line, filename or stdin.
  delete         Delete clusters,instancegroups, or secrets.
  describe       Describe a resource.
  edit           Edit clusters and other resources.
  export         Export configuration.
  get            Get one or many resources.
  help           Help about any command
  import         Import a cluster.
  replace        Replace cluster resources.
  rolling-update Rolling update a cluster.
  set            Set fields on clusters and other resources.
  toolbox        Misc infrequently used commands.
  update         Update a cluster.
  upgrade        Upgrade a kubernetes cluster.
  validate       Validate a kops cluster.
  version        Print the kops version information.

Flags:
      --alsologtostderr                  log to standard error as well as files
      --config string                    yaml config file (default is $HOME/.kops.yaml)
  -h, --help                             help for kops
      --log_backtrace_at traceLocation   when logging hits line file:N, emit a stack trace (default :0)
      --log_dir string                   If non-empty, write log files in this directory
      --log_file string                  If non-empty, use this log file
      --log_file_max_size uint           Defines the maximum size a log file can grow to. Unit is megabytes. If the value is 0, the maximum file size is unlimited. (default 1800)
      --logtostderr                      log to standard error instead of files (default true)
      --name string                      Name of cluster. Overrides KOPS_CLUSTER_NAME environment variable
      --skip_headers                     If true, avoid header prefixes in the log messages
      --skip_log_headers                 If true, avoid headers when opening log files
      --state string                     Location of state storage (kops 'config' file). Overrides KOPS_STATE_STORE environment variable
      --stderrthreshold severity         logs at or above this threshold go to stderr (default 2)
  -v, --v Level                          number for the log level verbosity
      --vmodule moduleSpec               comma-separated list of pattern=N settings for file-filtered logging

Use "kops [command] --help" for more information about a command.
