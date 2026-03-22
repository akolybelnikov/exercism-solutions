defmodule Newsletter do
  def read_emails(path) do
    emails = File.read!(path)
    String.split(emails, "\n", trim: true)
  end

  def open_log(path) do
    {_, pid} = File.open(path, [:write])
    pid
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, String.to_charlist(email))
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    log = open_log(log_path)

    read_emails(emails_path)
    |> Enum.map(fn email ->
      if send_fun.(email) == :ok do
        log_sent_email(log, email)
      end
    end)

    File.close(log)
  end
end
