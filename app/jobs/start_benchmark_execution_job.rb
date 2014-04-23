class StartBenchmarkExecutionJob < Struct.new(:benchmark_definition_id, :benchmark_execution_id)
  def perform
    benchmark_definition = BenchmarkDefinition.find(benchmark_definition_id)
    benchmark_execution = BenchmarkExecution.find(benchmark_execution_id)

    # TODO: Handle exit code, Avoid sudo, Handle situation when runner don't do a nohup => kill job
    %x( cd "#{benchmark_definition.vagrant_directory_path}" &&
        vagrant ssh -- 'cd /usr/local/cloud-benchmark; nohup ./start_runner.sh > /dev/null 2>&1 &' )

    benchmark_execution.status = 'RUNNING'
    benchmark_execution.save
  end
end