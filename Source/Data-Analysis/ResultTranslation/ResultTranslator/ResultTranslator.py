import clr
import os

clr.AddReference(os.path.abspath(os.path.join(os.getcwd(), "..", "VR-Processor", "bin", "Debug", "NewtonSoft.Json.dll")))
clr.AddReference(os.path.abspath(os.path.join(os.getcwd(), "..", "VR-Processor", "bin", "Debug", "VR-Processor.dll")))

from VR_Processor import ANTRCompResult, ExperimentResult

def convert_results_all():
    original_results_folder = os.path.abspath(os.path.join(os.getcwd(), "..", "..", "..", "..", "Data", "ANT-VR"))
    original_result_files = [f for f in os.listdir(original_results_folder) if f.endswith('.json')]

    for file in original_result_files:
        file_path = os.path.join(original_results_folder, file)
        antr_comp_result_file_name = file_path.replace(".json", ".txt")
        antr_comp_result = ANTRCompResult(ExperimentResult.Read(file_path))
        antr_comp_result.Save(antr_comp_result_file_name)

    balanced_results_folder = os.path.abspath(os.path.join(os.getcwd(), "..", "..", "..", "..", "Data", "ANT-VR Balanced"))
    balanced_result_files = [f for f in os.listdir(balanced_results_folder) if f.endswith('.json')]

    for file in balanced_result_files:
        file_path = os.path.join(balanced_results_folder, file)
        antr_comp_result_file_name = file_path.replace(".json", ".txt")
        antr_comp_result = ANTRCompResult(ExperimentResult.Read(file_path))
        antr_comp_result.Save(antr_comp_result_file_name)

convert_results_all()
