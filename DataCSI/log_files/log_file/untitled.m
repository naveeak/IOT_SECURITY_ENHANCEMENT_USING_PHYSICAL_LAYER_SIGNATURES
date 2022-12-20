%%Read an hdf5 image and plot in MATLAB
%%Load the hdf5 file in MATLAB
info = h5info('sta_two_node_two_flow_capture.hdf5');
%%Find the addres of the image
% The operation must be done manually and the position inside the structure
% could be variable depending on the structure itself
address_data_1 = info.GroupHierarchy.Groups().Datasets().Datasets;
%%Query the database
image1 =h5read('sta_two_node_two_flow_capture.hdf5',address_data_1);
%%Plot the image
figure
imagesc(image1)