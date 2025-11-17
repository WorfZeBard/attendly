import os

def collect_dart_files(root_directory, output_file):
    with open(output_file, "w", encoding="utf-8") as outfile:
        for current_path, dirs, files in os.walk(root_directory):
            for file in files:
                if file.endswith(".dart"):
                    full_path = os.path.join(current_path, file)

                    # Divider showing file path
                    outfile.write("\n" + "="*80 + "\n")
                    outfile.write(f"// FILE: {full_path}\n")
                    outfile.write("="*80 + "\n\n")

                    # Read and write the content
                    try:
                        with open(full_path, "r", encoding="utf-8") as dart_file:
                            outfile.write(dart_file.read())
                    except Exception as e:
                        outfile.write(f"// ERROR READING FILE: {e}\n")

    print(f"Done! All Dart files have been collected into: {output_file}")


# -------------------------
# MODIFY THESE TWO LINES
# -------------------------

root_directory = "."        # Main directory ('.' means current folder)
output_file    = "dart_files_output.txt"

collect_dart_files(root_directory, output_file)
