import os

from tqdm import tqdm


def extract_ucf_hmdb():
    datasets = ['ucf101', 'hmdb51']
    for dataset in datasets:
        root_path = f'/nfs/s3_common_dataset/UCF-HMDB-full/{dataset}/RGB'
        for class_name in tqdm(os.listdir(root_path)):
            print(f'extracting class [[[{class_name}]]]')
            class_path = f'{root_path}/{class_name}'
            if not os.path.isdir(class_path):
                continue
            for video_name in os.listdir(class_path):
                if not video_name.endswith('.avi'):
                    continue
                video_path = f'{class_path}/{video_name}'

                output_root = f'/nfs/ofs-902-1/object-detection/jiangjing/datasets/UCF-HMDB-full-freames/{dataset}'
                video_name_prefix, _ = os.path.splitext(video_name)
                output_dir = f'{output_root}/{class_name}'
                if not os.path.exists(output_dir):
                    os.makedirs(output_dir)
                output_dir = f'{output_dir}/{video_name_prefix}'
                if not os.path.exists(output_dir):
                    os.makedirs(output_dir)
                cmd = f'ffmpeg -i {video_path} {output_dir}/%5d.jpg -loglevel error'
                print(f'extracting [{video_name}]')
                os.system(cmd)


def check_num_frames():
    datasets = ['ucf101', 'hmdb51']
    for dataset in datasets:
        root_path = f'/nfs/s3_common_dataset/UCF-HMDB-full/{dataset}/RGB'
        output_root = f'/nfs/ofs-902-1/object-detection/jiangjing/datasets/UCF-HMDB-full-freames/{dataset}'
        for class_name in tqdm(os.listdir(output_root)):
            class_path = f'{output_root}/{class_name}'
            for video_name in os.listdir(class_path):
                video_path = f'{class_path}/{video_name}'
                num_frames = len(os.listdir(video_path))
                if num_frames < 16:
                    print(f'num_frames={num_frames}, {video_path}')

                    # re extract
                    video_name_prefix, _ = os.path.splitext(video_name)
                    output_dir = f'{output_root}/{class_name}'
                    if not os.path.exists(output_dir):
                        os.makedirs(output_dir)
                    output_dir = f'{output_dir}/{video_name_prefix}'
                    if not os.path.exists(output_dir):
                        os.makedirs(output_dir)
                    video_path = f'{root_path}/{class_name}/{video_name}.avi'
                    cmd = f"ffmpeg -i '{video_path}' '{output_dir}'/%5d.jpg -loglevel error"
                    print(f'extracting [{video_name}]')
                    os.system(cmd)


if __name__ == '__main__':
    # extract_ucf_hmdb()
    check_num_frames()
