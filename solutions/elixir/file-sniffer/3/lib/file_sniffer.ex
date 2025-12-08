defmodule FileSniffer do
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"	
      "png" -> "image/png"	
      "jpg" -> "image/jpg"	
      "gif" -> "image/gif"	
      _ -> nil
    end
  end

  def type_from_binary(file_binary) do
    detect_file_type(file_binary)
  end

  defp detect_file_type(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>), do: "application/octet-stream"	
  defp detect_file_type(<<"BM", _::binary>>), do: "image/bmp"	
  defp detect_file_type(<<0xFF, 0xD8, 0xFF, _::binary>>), do: "image/jpg"	
  defp detect_file_type(<<0x89, "PNG\r\n", 0x1A, 0x0A, _::binary>>), do: "image/png"	
  defp detect_file_type(<<"GIF8", _::binary>>), do: "image/gif"	
  defp detect_file_type(_), do: nil

  def verify(file_binary, extension) do
    type = type_from_extension(extension)
    if type != nil && type == type_from_binary(file_binary) do 
      {:ok, type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
